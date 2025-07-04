//
//  CoreDataTaskLocalDataSource.swift
//  TodoApp
//
//  Created by Edwin Yovany on 19/06/25.
//

import CoreData
import Combine

final class StorageTaskLocalDataSource: NSObject, TaskLocalDataSource {
    private let subject = CurrentValueSubject<[Task], Never>([])
    var tasksPublisher: AnyPublisher<[Task], Never> { subject.eraseToAnyPublisher() }

    static let shared = StorageTaskLocalDataSource()
    
    private let container: NSPersistentContainer = TodoPersistenceManager.shared.container
    private var viewContext: NSManagedObjectContext { container.viewContext }
    
    private lazy var frc: NSFetchedResultsController<TaskEntity> = {
        let req: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        req.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        
        let c = NSFetchedResultsController(
            fetchRequest: req,
            managedObjectContext: viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        c.delegate = self
        try? c.performFetch()
        subject.send((c.fetchedObjects ?? []).compactMap({ entity in entity.toDomain() }))
        return c
    }()
    
    override init() {
        super.init()
        _ = frc
    }
    
    func addTask(task: Task) throws {
        try viewContext.performAndWait {
            let entity = TaskEntity(context: viewContext)
            entity.id = task.id
            entity.title = task.title
            entity.contentDescription = task.description
            entity.isCompleted = task.isCompleted
            entity.category = task.category?.rawValue
            entity.date = task.date
            
            try viewContext.save()
        }
    }
    
    func updateTask(task: Task) throws {
        guard let entityToUpdate = try getTaskEntityById(taskId: task.id) else { return }
        
        entityToUpdate.title = task.title
        entityToUpdate.contentDescription = task.description
        entityToUpdate.isCompleted = task.isCompleted
        entityToUpdate.category = task.category?.rawValue
        entityToUpdate.date = task.date
        
        try viewContext.performAndWait {
            if viewContext.hasChanges {
                try viewContext.save()
            }
        }
        
    }
    
    func removeTask(task: Task) throws {
        guard let entityToDelete = try getTaskEntityById(taskId: task.id) else { return }
        
        try viewContext.performAndWait {
            viewContext.delete(entityToDelete)
            try viewContext.save()
        }
    }
    
    func deleteAllTasks() throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = TaskEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        deleteRequest.resultType = .resultTypeObjectIDs
        
        try viewContext.performAndWait {
            let result = try viewContext.execute(deleteRequest) as? NSBatchDeleteResult
            if let objectIDs = result?.result as? [NSManagedObjectID], !objectIDs.isEmpty {
                let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: objectIDs]
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [viewContext])
            }

            viewContext.reset()
        }
    }
    
    func getTaskById(taskId: String) throws -> Task? {
        let entity = try getTaskEntityById(taskId: taskId)
        return entity?.toDomain()
    }
    
    
    private func getTaskEntityById(taskId: String) throws -> TaskEntity? {
        let request: NSFetchRequest<TaskEntity> = TaskEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", taskId)
        request.fetchLimit = 1
        request.returnsObjectsAsFaults = false
        
        var entity: TaskEntity?
        
        try viewContext.performAndWait {
            let fetched = try viewContext.fetch(request)
            entity = fetched.first
        }
        
        return entity
    }
    
}

extension StorageTaskLocalDataSource: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        let objects = (controller.fetchedObjects as? [TaskEntity]) ?? []
        let newTasks = objects.compactMap({ entity in entity.toDomain() })

        if subject.value != newTasks {
            subject.send(newTasks)
        }
    }
}
