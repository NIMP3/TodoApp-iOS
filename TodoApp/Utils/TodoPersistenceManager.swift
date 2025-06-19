//
//  TaskPersistenManager.swift
//  TodoApp
//
//  Created by Edwin Yovany on 19/06/25.
//

import CoreData

final class TodoPersistenceManager {
    static let shared = TodoPersistenceManager()
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "ModelData")
        container.loadPersistentStores{ storeDescription, error in
            if let error = error {
                print("Error cargando datos: \(error)")
            } else {
                print("Carga de datos exitosa.")
            }
        }
    }
}
