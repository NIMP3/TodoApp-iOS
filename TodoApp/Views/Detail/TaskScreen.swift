//
//  TaskScreen.swift
//  TodoApp
//
//  Created by Edwin Yovany on 18/06/25.
//

import SwiftUI

public struct TaskScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State var viewModel: TaskScreenViewModel
    
    public var body: some View {
        let category = viewModel.state.category?.rawValue ?? "CATEGORY"
        
        VStack {
            HStack {
                Text("Done")
                    .padding(8)
                Toggle(isOn: $viewModel.state.isTaskDone, label: {})
                    .toggleStyle(iOSCheckbox())
                
                Spacer()
                
                HStack {
                    Text(category)
                        .font(.headline)
                        .padding(8)
                    
                    Image(systemName: "chevron.down")
                }
                .padding(EdgeInsets(top: 2, leading: 6, bottom: 2, trailing: 6))
                .overlay {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.primary, lineWidth: 1)
                }
            }
            .padding(.bottom, 24)
            
            TextField("Write a task",
                      text: $viewModel.state.taskName,
                      axis: .vertical)
                .font(.system(size: 36, weight: .medium))
                .lineLimit(2)
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            
            TextField("Write a description",
                      text: $viewModel.state.taskDescription,
                      axis: .vertical)
                .font(.system(size: 20, weight: .regular))
                .lineLimit(5)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            
            Spacer()
            
            Button(action: { viewModel.saveTask() }) {
                Text("SAVE")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color.blue)
                    .cornerRadius(16)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .navigationTitle("Task")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .padding(16)
        .onChange(of: viewModel.didSave, { _, newValue in
            guard newValue else { return }
            viewModel.didSave = false
            dismiss()
        })
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { dismiss() }
                label : {
                    Image(systemName: "chevron.backward")
                        .font(.title3.weight(.semibold))
                        .tint(.primary)
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        TaskScreen(
            viewModel: TaskScreenViewModel(
                id: nil,
                dataSource: FakeTaskLocalDataSource()))
    }
}
