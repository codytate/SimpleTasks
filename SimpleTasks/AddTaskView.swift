//
//  AddTaskView.swift
//  SimpleTasks
//
//  Created by Cody Tate on 10/4/25.
//

import SwiftUI

/// Screen to enter and save a new task into the shared TaskViewModel.
struct AddTaskView: View {
    // MARK: - Body
    
    @State private var newTask = ""
    @EnvironmentObject var taskVM: TaskViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter new task",text: $newTask)
                .accessibilityIdentifier("newTaskTextField")
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save Task") {
                let trimmed = newTask.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty else { return }
                taskVM.addTask(trimmed)
                newTask = ""
                dismiss() // return to previous screen
            }
            .accessibilityIdentifier("saveTaskButton")
            .buttonStyle(.borderedProminent)
            .disabled(newTask.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) // Disable until there's non-whitespace text
            
            Spacer()
        }
        .navigationTitle("Add Task")
        .padding()
    }
}

