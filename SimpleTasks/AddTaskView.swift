//
//  AddTaskView.swift
//  SimpleTasks
//
//  Created by Cody Tate on 10/4/25.
//

import SwiftUI

struct AddTaskView: View {
    @State private var newTask = ""
    @EnvironmentObject var taskVM: TaskViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter new task",text: $newTask)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save Task") {
                let trimmed = newTask.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty else { return }
                taskVM.addTask(trimmed)
                newTask = ""
                dismiss() // return to previous screen
            }
            .buttonStyle(.borderedProminent)
            .disabled(newTask.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            
            Spacer()
        }
        .navigationTitle("Add Task")
        .padding()
    }
}

