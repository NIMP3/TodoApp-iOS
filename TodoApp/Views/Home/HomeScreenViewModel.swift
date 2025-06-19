//
//  HomeScreenViewModel.swift
//  TodoApp
//
//  Created by Edwin Yovany on 6/06/25.
//

import Foundation

@Observable class HomeScreenViewModel {
    var state: HomeDataState = HomeDataState()
    private let dataSource: TaskLocalDataSource
    
    init(dataSource: TaskLocalDataSource) {
        self.dataSource = dataSource
        loadData()
    }
    
    private func loadData() {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "EE, MMMM, dd, yyyy"
        state.date = formatter.string(from: Date())
        
        state.completedTasks = dataSource.tasks
            .filter { $0.isCompleted }
            .sorted(by: { $0.date < $1.date })
        
        state.pendingTasks = dataSource.tasks
            .filter { !$0.isCompleted }
            .sorted(by: { $0.date < $1.date })
        
        state.summary = "\(state.pendingTasks) incomplete, \(state.completedTasks) completed)"
        
    }
    
    func addTask() {
        let tasks = FakeTaskLocalDataSource().tasks
        let random = Int.random(in: 0..<tasks.count)
        let task = tasks[random]
        
        do {
            try dataSource.addTask(task: task)
            loadData()
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
