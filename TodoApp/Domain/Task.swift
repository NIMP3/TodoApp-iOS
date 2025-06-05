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
    let isCompleted: Bool = false
    let category: Category? = nil
}
