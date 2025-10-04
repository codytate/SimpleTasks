//
//  SimpleTasksUITests.swift
//  SimpleTasksUITests
//
//  Created by Cody Tate on 10/4/25.
//

import XCTest

final class SimpleTasksUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    // Launch the app with a clean state for each test run
    private func launchApp() -> XCUIApplication {
        let app = XCUIApplication()
        app.launchArguments += ["-uiTestingReset"]
        app.launch()
        return app
    }

    // Helper to find the SwiftUI List regardless of underlying UIKit type (table vs collection view)
    private func tasksList(in app: XCUIApplication) -> XCUIElement {
        let table = app.tables["tasksList"]
        if table.exists { return table }
        let collection = app.collectionViews["tasksList"]
        if collection.exists { return collection }
        // Fallback to any element with the identifier if needed
        return app.descendants(matching: .any)["tasksList"]
    }

    @MainActor
    func testAddTaskFlow() throws {
        let app = launchApp()

        // 1) Tap the add button in the top bar
        let addButton = app.buttons["addTaskButton"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 5), "Add button should exist on the main screen")
        addButton.tap()

        // 2) Type a new task and save
        let textField = app.textFields["newTaskTextField"]
        XCTAssertTrue(textField.waitForExistence(timeout: 5), "New task text field should be visible")
        textField.tap()
        textField.typeText("Write UI tests")

        let saveButton = app.buttons["saveTaskButton"]
        XCTAssertTrue(saveButton.waitForExistence(timeout: 5) && saveButton.isEnabled, "Save button should be enabled when text is not empty")
        saveButton.tap()

        // 3) Verify the new task appears in the list
        let list = tasksList(in: app)
        XCTAssertTrue(list.waitForExistence(timeout: 5), "Tasks list should exist")
        XCTAssertTrue(list.staticTexts["Write UI tests"].waitForExistence(timeout: 5), "Newly added task should appear in the list")
    }

    @MainActor
    func testDeleteTaskFlow() throws {
        let app = launchApp()

        // Ensure the list exists and has at least one default task
        let list = tasksList(in: app)
        XCTAssertTrue(list.waitForExistence(timeout: 5), "Tasks list should exist")

        // Enter edit mode
        let editButton = app.buttons["editButton"]
        XCTAssertTrue(editButton.waitForExistence(timeout: 5), "Edit button should exist on the main screen")
        editButton.tap()

        // Swipe to delete the first cell (alternative to delete controls in edit mode)
        let firstCell = list.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "There should be at least one task to delete")

        // Try swipe-to-delete first
        if firstCell.buttons["Delete"].exists == false {
            firstCell.swipeLeft()
        }
        let deleteButton = firstCell.buttons["Delete"]
        XCTAssertTrue(deleteButton.waitForExistence(timeout: 5), "Delete button should appear after swiping left")
        deleteButton.tap()

        // Exit edit mode if needed
        if editButton.exists { editButton.tap() }
    }

    @MainActor
    func testNavigateToTaskDetail() throws {
        let app = launchApp()

        let list = tasksList(in: app)
        XCTAssertTrue(list.waitForExistence(timeout: 5), "Tasks list should exist")

        // Tap the first task to navigate to detail
        let firstCell = list.cells.element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "There should be at least one task to open")
        firstCell.tap()

        // Verify the detail screen by checking the navigation title and body text presence
        let navBar = app.navigationBars["Task Detail"]
        XCTAssertTrue(navBar.waitForExistence(timeout: 5), "Should navigate to Task Detail screen")

        // The detail view shows the task name as a large title text; verify a staticText exists in the view hierarchy
        XCTAssertTrue(app.staticTexts.element(boundBy: 0).exists, "Some text should be visible on the detail screen")
    }
}
