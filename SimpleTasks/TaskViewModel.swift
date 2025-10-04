//
//  TaskViewModel.swift
//  SimpleTasks
//
//  Created by Cody Tate on 10/4/25.
//

import SwiftUI
import Combine

/// View model that manages the list of tasks with simple UserDefaults persistence.
class TaskViewModel: ObservableObject {
    // MARK: - Published State
    
    @Published var tasks: [String] = [] {
        didSet {
            saveTasks()
        }
    }
    
    private let tasksKey = "tasks_key" //Key used in user default
    
    // MARK: - Init
    
    init() {
        // If the app is launched for UI testing with a reset flag, clear any persisted tasks
        if ProcessInfo.processInfo.arguments.contains("-uiTestingReset") {
            UserDefaults.standard.removeObject(forKey: tasksKey)
        }
        loadTask()
    }
    
    // MARK: - Public Methods
    
    /// Adds a new task string to the list.
    func addTask(_ task: String) {
        tasks.append(task)
    }
    
    /// Deletes tasks at the given index set.
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
    
    // MARK: - Persistence Methods
    private func saveTasks() {
        UserDefaults.standard.set(tasks, forKey: tasksKey)
    }
    
    private func loadTask() {
        if let savedTasks = UserDefaults.standard.array(forKey: tasksKey) as? [String] {
            tasks = savedTasks
        } else {
            tasks = ["Buy milk", "Read a book", "Go for a walk"]
        }
    }
}

