//
//  TaskScreenViewModel.swift
//  TodoApp
//
//  Created by Edwin Yovany on 25/06/25.
//

import Foundation

@MainActor
@Observable class TaskScreenViewModel {
    var state: TaskScreenState = TaskScreenState()
    var didSave: Bool = false
    
    @ObservationIgnored private let dataSource: TaskLocalDataSource
    @ObservationIgnored private var id: String? = nil

    init(dataSource: TaskLocalDataSource) {
        self.dataSource = dataSource
    }

    func loadData(id: String?) {
        guard let id = id else { return }
        self.id = id
        
        do {
            guard let task = try? dataSource.getTaskById(taskId: id) else { return }
            
            state.taskName = task.title
            state.taskDescription = task.description ?? ""
            state.category = task.category
            state.isTaskDone = task.isCompleted
            state.date = task.date
        }
    }
    
    func saveTask() {
        let isNew = id == nil
        let task = Task(id: isNew ? UUID().uuidString : id!,
                         title: state.taskName,
                         description: state.taskDescription,
                         isCompleted: state.isTaskDone,
                         category: state.category,
                         date: isNew ? Date() : state.date)
        
        do {
            if isNew { try dataSource.addTask(task: task) }
            else { try dataSource.updateTask(task: task) }
            didSave = true
        } catch {
            print("Error while \(isNew ? "adding" : "updating") task: \(error)")
        }
    }
}
