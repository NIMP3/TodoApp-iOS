//
//  ContentView.swift
//  TodoApp
//
//  Created by Edwin Yovany on 3/06/25.
//

import SwiftUI 

struct ContentView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeScreen() { id in
                path.append(AppRoute.taskDetail(id: id))
            }
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .home: EmptyView()
                case .taskDetail(let id):
                    TaskScreen(viewModel: TaskScreenViewModel(id: id, dataSource: StorageTaskLocalDataSource()))
                }
            }
        }
    }
}

enum AppRoute: Hashable {
    case home
    case taskDetail(id: String?)
}

#Preview {
    ContentView()
}
