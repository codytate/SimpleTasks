//
//  TaskViewModel.swift
//  SimpleTasks
//
//  Created by Cody Tate on 10/4/25.
//

import SwiftUI
import Combine

class TaskViewModel: ObservableObject {
    @Published var tasks: [String] = ["Buy milk", "Walk the dog", "Learn Swift"]
    
    func addTask(_ task: String) {
        tasks.append(task)
    }
}

