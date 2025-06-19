//
//  Task.swift
//  TodoApp
//
//  Created by Edwin Yovany on 4/06/25.
//

import Foundation

struct Task: Identifiable, Equatable {
    var id: String = UUID().uuidString
    let title: String
    let description: String?
    var isCompleted: Bool
    let category: Category?
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
}
