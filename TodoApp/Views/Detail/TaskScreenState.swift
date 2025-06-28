//
//  TaslScreenState.swift
//  TodoApp
//
//  Created by Edwin Yovany on 25/06/25.
//

import Foundation

struct TaskScreenState {
    var taskName: String = ""
    var taskDescription: String = ""
    var category: Category?
    var isTaskDone: Bool = false
    var date: Date = Date()
    var canSaveTask: Bool {
        !taskName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
