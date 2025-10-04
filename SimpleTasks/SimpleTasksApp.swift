//
//  SimpleTasksApp.swift
//  SimpleTasks
//
//  Created by Cody Tate on 10/4/25.
//

import SwiftUI

@main
struct SimpleTasksApp: App {
    @StateObject private var taskVM = TaskViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taskVM) //share data across all views
        }
    }
}
