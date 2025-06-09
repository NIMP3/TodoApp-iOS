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
    let isCompleted: Bool
    let category: Category?
    
    init(title: String, description: String?, isCompleted: Bool = false, category: Category? = nil) {
        self.title = title
        self.description = description
        self.isCompleted = isCompleted
        self.category = category
    }
}
