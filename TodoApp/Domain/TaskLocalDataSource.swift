//
//  TaskLocalDataSource.swift
//  TodoApp
//
//  Created by Edwin Yovany on 6/06/25.
//
import CoreData
import Combine

protocol TaskLocalDataSource {
    var tasksPublisher: AnyPublisher<[Task], Never> { get }
    
    var tasks: [Task] { get }
    func addTask(task: Task) throws
    func updateTask(task: Task) throws
    func removeTask(task: Task) throws
    func deleteAllTasks() throws
    func getTaskById(taskId: String) throws -> Task?
}
