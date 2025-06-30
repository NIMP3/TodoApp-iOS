//
//  Category.swift
//  TodoApp
//
//  Created by Edwin Yovany on 4/06/25.
//

enum Category: String, CaseIterable {
    case WORK = "WORK"
    case PERSONAL = "PERSONAL"
    case SHOPPING = "SHOPPING"
    case STUDY = "STUDY"
    case OTHER = "OTHER"

    var hexColor: String {
        switch self {
        case .WORK: return "#007AFF"
        case .PERSONAL: return "#FF9500"
        case .SHOPPING: return "#34C759"
        case .STUDY: return "#AF52DE"
        case .OTHER: return "#8E8E93"
        }
    }
}
