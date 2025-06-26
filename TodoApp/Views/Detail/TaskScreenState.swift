//
//  TaslScreenState.swift
//  TodoApp
//
//  Created by Edwin Yovany on 25/06/25.
//

struct TaskScreenState {
    var taskName: String = ""
    var taskDescription: String = ""
    var category: Category?
    var isTaskDone: Bool = false
    var canSaveTask: Bool = false
}
