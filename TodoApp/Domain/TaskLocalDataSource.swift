//
//  TaskLocalDataSource.swift
//  TodoApp
//
//  Created by Edwin Yovany on 6/06/25.
//

protocol TaskLocalDataSource {
    var tasks: [Task] { get set }
    func addTask(task: Task)
    func updateTask(task: Task)
    func removeTask(task: Task)
    func deleteAllTasks()
    func getTaskById(taskId: String) -> Task?
}
