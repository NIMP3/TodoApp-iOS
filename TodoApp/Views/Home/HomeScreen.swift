//
//  HomeScreen.swift
//  TodoApp
//
//  Created by Edwin Yovany on 4/06/25.
//

import SwiftUI

public struct HomeScreen: View {
    @State var viewModel = HomeScreenViewModel(dataSource: StorageTaskLocalDataSource())
    let onEditTask: (String?) -> Void
    
    public var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomTrailing) {
                if !viewModel.state.completedTasks.isEmpty || !viewModel.state.pendingTasks.isEmpty {
                    HomeScreenContent(viewModel: $viewModel,
                                      containerWidth: geometry.size.width,
                                      onEditTask: onEditTask)
                }
                else { MessageView() }
                
                Button { onEditTask(nil) }
                label: {
                    Image(systemName: "plus")
                        .frame(width: 24, height: 24)
                        .font(.title.weight(.semibold))
                        .padding(16)
                        .foregroundStyle(.white)
                        .background(.primary)
                        .clipShape(Circle())
                        .shadow(radius: 4, x: 0, y: 4)
                }
                .padding(12)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .navigationTitle("TodoApp")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button{ }
                label : {
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(Color.primary)
                }
            }
        }
    }
}

struct HomeScreenContent: View {
    @Binding var viewModel: HomeScreenViewModel
    let containerWidth: CGFloat
    let onEditTask: (String?) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack {
                SummaryInfo(
                    date: viewModel.state.date,
                    pendingTasks: viewModel.state.pendingTasks.count,
                    completedTasks: viewModel.state.completedTasks.count,
                    totalTaks: viewModel.state.completedTasks.count + viewModel.state.pendingTasks.count,
                    containerWidth: containerWidth)
                
                SectionTitle(title: "Completed")
                ForEach(viewModel.state.completedTasks) { task in
                    TaskItem(task: task, onDelete: {
                        viewModel.deleteTask(task: task)
                    }, onToggle: { updatedTask in
                        viewModel.updateTask(task: updatedTask)
                    })
                    .onTapGesture { onEditTask(task.id) }
                }
                .padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                
                SectionTitle(title: "Pending")
                ForEach(viewModel.state.pendingTasks) { task in
                    TaskItem(task: task, onDelete: {
                        viewModel.deleteTask(task: task)
                    }, onToggle: { updatedTask in
                        viewModel.updateTask(task: updatedTask)
                    })
                    .onTapGesture { onEditTask(task.id) }
                }
                .padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                
            }
        }
        .scrollIndicators(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
        }
    }
}

struct MessageView: View {
    var body: some View {
        VStack {
            Text("No tasks yet")
                .font(.headline)
            Text("Add your first task")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}


#Preview {
    NavigationView {
        HomeScreen() { _ in
        }
    }
}
