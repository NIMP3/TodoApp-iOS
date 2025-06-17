//
//  Task.swift
//  TodoApp
//
//  Created by Edwin Yovany on 4/06/25.
//

import Foundation

struct Task: Identifiable, Equatable {
    let id: String = UUID().uuidString
    let title: String
    let description: String?
    var isCompleted: Bool
    let category: Category?
    let date: Date = Date()
    
    init(title: String, description: String?, isCompleted: Bool = false, category: Category? = nil) {
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.category = category
    }
}
