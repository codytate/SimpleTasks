//
//  ContentView.swift
//  SimpleTasks
//
//  Created by Cody Tate on 10/4/25.
//

import SwiftUI

/// Root view showing the list of tasks and toolbar controls to add or edit tasks.
struct ContentView: View {
    // MARK: - Body

    @EnvironmentObject var taskVM: TaskViewModel
    
    var body: some View {
        NavigationStack {
            List{
                ForEach (taskVM.tasks, id: \.self) { task in
                    NavigationLink(destination: TaskDetailView(taskName: task)) {
                        Text(task)
                    }
                    .accessibilityIdentifier("taskRow_\(task)")
                }
                .onDelete(perform: taskVM.deleteTask)
            }
            .accessibilityIdentifier("tasksList")
            .navigationTitle(Text("My Tasks"))
            .toolbar {
                ToolbarItem(placement:.topBarTrailing) {
                    NavigationLink(destination: AddTaskView()) {
                        Label("Add", systemImage: "plus.circle.fill")
                    }
                    .accessibilityIdentifier("addTaskButton")
                }
                ToolbarItem(placement:.bottomBar) {
                    EditButton()
                        .accessibilityIdentifier("editButton")
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TaskViewModel())
}
