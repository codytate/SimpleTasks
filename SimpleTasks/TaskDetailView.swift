//
//  TaskDetailView.swift
//  SimpleTasks
//
//  Created by Cody Tate on 10/4/25.
//

import SwiftUI

struct TaskDetailView: View {
    let taskName: String
    
    var body: some View {
        VStack(spacing: 20){
            Text(taskName)
                .font(.title)
                .padding()
            
            Text("This is where you could add more info about the '\(taskName)'.")
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .navigationTitle("Task Detail")
        .padding()
    }
}
