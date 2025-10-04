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
            }
            .navigationTitle(Text("My Tasks"))
            .toolbar {
                NavigationLink(destination: AddTaskView()) {
                    Label("Add", systemImage: "plus.circle.fill")
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(TaskViewModel())
}
