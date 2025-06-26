//
//  TaskEntity+CoreDataProperties.swift
//  TodoApp
//
//  Created by Edwin Yovany on 19/06/25.
//
//

import Foundation
import CoreData


extension TaskEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TaskEntity> {
        return NSFetchRequest<TaskEntity>(entityName: "TaskEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var category: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var title: String?
    @NSManaged public var contentDescription: String?
    @NSManaged public var id: String?

}

extension TaskEntity : Identifiable {
    func toDomain() -> Task? {
        guard   let id = self.id, let title = self.title,
                let date = self.date else {
            return nil
        }
        
        return Task(id: id,
                    title: title,
                    description: self.contentDescription,
                    isCompleted: self.isCompleted,
                    category: Category(rawValue: self.category ?? ""),
                    date: date)
    }
}
