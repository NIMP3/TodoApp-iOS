//
//  Task.swift
//  TodoApp
//
//  Created by Edwin Yovany on 4/06/25.
//

import Foundation

struct Task: Identifiable, Equatable {
    var id: String = UUID().uuidString
    var title: String
    var description: String?
    var isCompleted: Bool
    var category: Category?
    var date: Date = Date()
    
    init(title: String, description: String?, isCompleted: Bool = false, category: Category? = nil) {
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.category = category
    }
    
    init(id: String, title: String, description: String?, isCompleted: Bool, category: Category?, date: Date) {
        self.id = id
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.category = category
        self.date = date
    }

    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id &&
               lhs.title == rhs.title &&
               lhs.description == rhs.description &&
               lhs.isCompleted == rhs.isCompleted &&
               lhs.category == rhs.category &&
               lhs.date == rhs.date
    }
}
