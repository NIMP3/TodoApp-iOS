//
//  HomeScreen.swift
//  TodoApp
//
//  Created by Edwin Yovany on 4/06/25.
//

import SwiftUI

public struct HomeScreen: View {
    @State var viewModel = HomeScreenViewModel(dataSource: FakeTaskLocalDataSource())
    
    public var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVStack {
                    SummaryInfo(
                        date: viewModel.state.date,
                        pendingTasks: viewModel.state.pendingTasks.count,
                        completedTasks: viewModel.state.completedTasks.count,
                        totalTaks: viewModel.state.completedTasks.count + viewModel.state.pendingTasks.count,
                        containerWidth: geometry.size.width)
                    
                    SectionTitle(title: "Completed")
                    ForEach(viewModel.state.completedTasks) { task in
                        TaskItem(task: task)
                    }
                    .padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                    
                    SectionTitle(title: "Pending")
                    ForEach(viewModel.state.pendingTasks) { task in
                        TaskItem(task: task)
                    }
                    .padding(EdgeInsets(top: 2, leading: 12, bottom: 2, trailing: 12))
                    
                }
            }
            .scrollIndicators(.hidden)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
            }
        }
        .navigationTitle("TodoApp")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button{
                    
                }
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


#Preview {
    NavigationView {
        HomeScreen()
    }
}
