//
//  ContentView.swift
//  SimpleTasks
//
//  Created by Cody Tate on 10/4/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var taskVM: TaskViewModel
    
    var body: some View {
        NavigationStack {
            List{
                ForEach (taskVM.tasks, id: \.self) { task in
                    NavigationLink(destination: TaskDetailView(taskName: task)) {
                        Text(task)
                    }
                }
                .onDelete(perform: taskVM.deleteTask)
            }
            .navigationTitle(Text("My Tasks"))
            .toolbar {
                ToolbarItem(placement:.topBarTrailing) {
                    NavigationLink(destination: AddTaskView()) {
                        Label("Add", systemImage: "plus.circle.fill")
                    }
                }
                ToolbarItem(placement:.bottomBar) {
                    EditButton()
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TaskViewModel())
}
