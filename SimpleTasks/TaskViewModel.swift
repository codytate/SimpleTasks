//
//  TaskViewModel.swift
//  SimpleTasks
//
//  Created by Cody Tate on 10/4/25.
//

import SwiftUI
import Combine

class TaskViewModel: ObservableObject {
    @Published var tasks: [String] = [] {
        didSet {
            saveTasks()
        }
    }
    
    private let tasksKey = "tasks_key" //Key used in user default
    
    init() {
        loadTask()
    }
    
    func addTask(_ task: String) {
        tasks.append(task)
    }
    
    func deleteTask(at offets: IndexSet) {
        tasks.remove(atOffsets: offets)
    }
    
    // MARK: - Persistence Methods
    private func saveTasks() {
        UserDefaults.standard.set(tasks, forKey: tasksKey)
    }
    
    private func loadTask() {
        if let savedTasks = UserDefaults.standard.array(forKey: tasksKey) as? [String] {
            tasks = savedTasks
        } else{
            tasks = ["Buy milk", "Read a book", "Go for a walk"]
        }
    }
}

