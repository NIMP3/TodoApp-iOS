//
//  FakeTaskLocalDataSource.swift
//  TodoApp
//
//  Created by Edwin Yovany on 9/06/25.
//

class FakeTaskLocalDataSource: TaskLocalDataSource {
    var tasks: [Task]
    private var completedTasks: [Task] = []
    private var pendingTasks: [Task] = []
    
    init() {
        completedTasks = [
            Task(title: "I have to do my homework",
                 description: "I have to do my homework for the next week",
                 isCompleted: true,
                 category: .STUDY
                ),
            Task(title: "I have to do exercise",
                 description: "I have to do exercise for the next week",
                 isCompleted: true,
                 category: .PERSONAL
                )
        ]
        
        pendingTasks = [
            Task(title: "I have to prepare the presentation",
                 description: "I have to prepare the presentation for the next week",
                 isCompleted: false,
                 category: .STUDY
                ),
            Task(title: "I have to buy a new phone",
                 description: "I have to buy a new phone for the next week",
                 isCompleted: false,
                 category: .SHOPPING
                 ),
            Task(title: "I have to ride my bike and go out with my father",
                 description: "I have to ride my bike and go out with my father this weekend",
                 isCompleted: false,
                 category: .PERSONAL
                ),
            Task(title: "I have to manage my PBIs on the Azure DevOps",
                 description: "I have to manage my PBIs on the Azure DevOps this weekend",
                 isCompleted: false,
                 category: .WORK
                 ),
            Task(title: "I have to watch a movie with my family",
                 description: "I have to watch a movie with my family this weekend",
                 isCompleted: false,
                 category: .PERSONAL
                ),
            Task(title: "I have to pay the bills",
                 description: "I have to pay the bills this weekend",
                 isCompleted: false,
                 category: .SHOPPING
                ),
            Task(title: "I have to go to the supermarket",
                 description: "I have to go to the supermarket this weekend",
                 isCompleted: false,
                 category: .SHOPPING
                ),
            Task(title: "I have to apply for my car license",
                 description: "I have to apply for my car license this weekend",
                 isCompleted: false,
                 category: .PERSONAL
                ),
            Task(title: "I have to go to the bank",
                 description: "I have to go to the bank this weekend",
                 isCompleted: false,
                 category: .OTHER
                ),
        ]
        
        self.tasks = completedTasks + pendingTasks
    }
    
    func addTask(task: Task) {
        self.tasks.append(task)
    }
    
    func updateTask(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        self.tasks[index] = task
    }
    
    func removeTask(task: Task) {
        guard let index = tasks.firstIndex(of: task) else { return }
        tasks.remove(at: index)
    }
    
    func deleteAllTasks() {
        tasks.removeAll()
    }
    
    func getTaskById(taskId: String) -> Task? {
        return tasks.first { dataTask in dataTask.id == taskId }
    }
}
