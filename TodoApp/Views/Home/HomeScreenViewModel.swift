//
//  HomeScreenViewModel.swift
//  TodoApp
//
//  Created by Edwin Yovany on 6/06/25.
//

import Foundation
import CoreData
import Combine

@MainActor
@Observable class HomeScreenViewModel {
    var state: HomeDataState = HomeDataState()
    
    @ObservationIgnored private let dataSource: TaskLocalDataSource
    private var cancellables: Set<AnyCancellable> = []
    
    
    init(dataSource: TaskLocalDataSource) {
        self.dataSource = dataSource
        
        loadInitData()
        dataSource.tasksPublisher
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] tasks in
                self?.updateState(with: tasks)
            }
            .store(in: &cancellables)
    }
    
    private func updateState(with tasks: [Task]) {
        state.completedTasks = tasks.filter(\.isCompleted)
        state.pendingTasks   = tasks.filter { !$0.isCompleted }
        state.summary   = "\(state.pendingTasks.count) incomplete, \(state.completedTasks.count) completed"
   }
    
    private func loadInitData() {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "EE, MMMM, dd, yyyy"
        state.date = formatter.string(from: Date())
    }
    
    func deleteTask(task: Task) {
        do {
            try dataSource.removeTask(task: task)
        } catch {
            print("Error when deleting task: \(error.localizedDescription)")
        }
    }
    
    func updateTask(task: Task) {
        do {
            try dataSource.updateTask(task: task)
        } catch {
            print("Error when updating task: \(error.localizedDescription)")
        }
    }
    
}
