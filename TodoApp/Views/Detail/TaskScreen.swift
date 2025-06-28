//
//  TaskScreen.swift
//  TodoApp
//
//  Created by Edwin Yovany on 18/06/25.
//

import SwiftUI

public struct TaskScreen: View {
    let id: String?

    @Environment(\.dismiss) private var dismiss
    @Environment(TaskScreenViewModel.self) private var viewModel
    @State private var showDropDown: Bool = false
    @State private var selectedOptionIndex: Int? = nil
    
    private let categories = Category.allCases.map(\.rawValue)
    
    public var body: some View {
        ZStack {
            if showDropDown {
                DropDownMenu(options: categories,
                             onItemSelected: { index in
                                 selectedOptionIndex = index
                                 viewModel.state.category = Category(rawValue: categories[index])
                                 showDropDown = false
                             },
                             selectedOptionIndex: $selectedOptionIndex)
                    .zIndex(1)
                    .offset(y: 46)
            }

            TaskScreenForm(viewModel: viewModel, showDropDown: $showDropDown)
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
        .onAppear {
            viewModel.loadData(id: id)
            if let category = viewModel.state.category {
                selectedOptionIndex = categories.firstIndex(of: category.rawValue)
            }
        }
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

public struct TaskScreenForm: View {
    let viewModel: TaskScreenViewModel
    @Binding var showDropDown: Bool
    
    public var body: some View {
        VStack {
            HStack {
                Text("Done")
                    .padding(8)
                Toggle("", isOn: Binding<Bool>(
                        get: { viewModel.state.isTaskDone },
                        set: { viewModel.state.isTaskDone = $0 }
                    ))
                    .toggleStyle(iOSCheckbox())
                
                Spacer()

                DropDownLabel(placeholder: viewModel.state.category?.rawValue ?? "CATEGORY",
                               showDropDown: $showDropDown)
            
            }
            .padding(.bottom, 24)
            
            TextField("Write a task",
                      text: Binding<String>(
                        get: { viewModel.state.taskName },
                        set: { viewModel.state.taskName = $0 }
                      ),
                      axis: .vertical)
                .font(.system(size: 36, weight: .medium))
                .lineLimit(2)
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            
            TextField("Write a description",
                      text: Binding<String>(
                        get: { viewModel.state.taskDescription },
                        set: { viewModel.state.taskDescription = $0 }
                      ),
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
                    .background(viewModel.state.canSaveTask ? Color.blue : Color.gray)
                    .cornerRadius(16)
            }
            .disabled(!viewModel.state.canSaveTask)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct DropDownLabel: View {
    let placeholder: String
    @Binding var showDropDown: Bool

    public var body: some View {
        Button(action: {
                withAnimation { showDropDown.toggle() }
            }, label: {
                HStack {
                    Text(placeholder)
                        .font(.headline)
                        .foregroundStyle(Color.primary)
                        .padding(8)
                    
                    Image(systemName: "chevron.down")
                        .padding(8)
                        .foregroundStyle(Color.primary)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color.primary, lineWidth: 1)
                }
            })
            .padding(.bottom, 6)
    }
}

#Preview {
    NavigationView {
        TaskScreen(id: nil)
    }
}
