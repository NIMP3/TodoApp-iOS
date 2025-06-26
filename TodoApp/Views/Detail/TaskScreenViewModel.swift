//
//  TaskScreenViewModel.swift
//  TodoApp
//
//  Created by Edwin Yovany on 25/06/25.
//

import Foundation

@MainActor
@Observable class TaskScreenViewModel: ObservableObject {
    var state: TaskScreenState = TaskScreenState()
    var didSave: Bool = false
    
    @ObservationIgnored private let dataSource: TaskLocalDataSource
    @ObservationIgnored private let id: String?
    
    init(id: String?, dataSource: TaskLocalDataSource) {
        self.dataSource = dataSource
        self.id = id
        loadData()
    }
    
    private func loadData() {
        guard let id = id else { return }
        
        do {
            guard let task = try? dataSource.getTaskById(taskId: id) else { return }
            
            state.taskName = task.title
            state.taskDescription = task.description ?? ""
            state.category = task.category
            state.isTaskDone = task.isCompleted
        }
    }
    
    func saveTask() {
        let isNew = id == nil
        let task = Task(id: isNew ? UUID().uuidString : id!,
                         title: state.taskName,
                         description: state.taskDescription,
                         isCompleted: state.isTaskDone,
                         category: state.category,
                         date: Date())
        
        do {
            if isNew { try dataSource.addTask(task: task) }
            else { try dataSource.updateTask(task: task) }
            didSave = true
        } catch {
            print("Error while \(isNew ? "adding" : "updating") task: \(error)")
        }
    }
}
