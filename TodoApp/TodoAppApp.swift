//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Edwin Yovany on 3/06/25.
//

import SwiftUI

@main
struct TodoAppApp: App {
    @State private var homeScreenViewModel = HomeScreenViewModel(dataSource: StorageTaskLocalDataSource.shared)
    @State private var taskScreenViewModel = TaskScreenViewModel(dataSource: StorageTaskLocalDataSource.shared)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(homeScreenViewModel)
                .environment(taskScreenViewModel)
        }
    }
}
