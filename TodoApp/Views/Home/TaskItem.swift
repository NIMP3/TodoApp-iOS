//
//  TaskItem.swift
//  TodoApp
//
//  Created by Edwin Yovany on 10/06/25.
//

import SwiftUI

public struct TaskItem: View {
    @State var task: Task
    var onDelete: (() -> Void)?
    var onToggle: ((Task) -> Void)?
    
    public var body: some View {
        VStack(alignment: .trailing){
            HStack{
                Toggle("", isOn: Binding<Bool>(
                        get: { task.isCompleted },
                        set: { newValue in
                            var updated = task
                            updated.isCompleted = newValue
                            onToggle?(updated)
                        }
                    ))
                    .toggleStyle(iOSCheckbox())
                    .padding(6)
                
                VStack(alignment: .leading){
                    Text(task.title)
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .fontWeight(.medium)
                        .padding(.bottom, 4)
                    
                    if !task.isCompleted, let description = task.description {
                        Text(description)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button { onDelete?() }
                label: {
                    Image(systemName: "trash.fill")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.primary)
                        .padding(6)
                }
            }
            .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 12))
            
            if !task.isCompleted, let category = task.category?.rawValue {
                Text(category)
                    .font(.footnote)
                    .foregroundStyle(.white)
                    .fontWeight(.medium)
                    .padding(6)
                    .background(.cyan)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(12)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(8)
        .background(.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

#Preview {
    TaskItem(
        task: Task(title: "I have to write my CV",
                   description: "I have to write my curriculum vitae in English because. I need to apply to new opportunities",
                   isCompleted: true,
                   category: .PERSONAL))
}
