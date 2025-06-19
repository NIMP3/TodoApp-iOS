//
//  TaskScreen.swift
//  TodoApp
//
//  Created by Edwin Yovany on 18/06/25.
//

import SwiftUI

public struct TaskScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    public var body: some View {
        VStack {
            HStack {
                Text("Done")
                    .padding(8)
                Toggle(isOn: .constant(true), label: {})
                    .toggleStyle(iOSCheckbox())
                
                Spacer()
                
                HStack {
                    Text("CATEGORY")
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
                      text: .constant("I have to do my homework"),
                      axis: .vertical)
                .font(.system(size: 36, weight: .medium))
                .lineLimit(2)
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            
            TextField("Write a description",
                      text: .constant("I have to do my homework for the next week"),
                      axis: .vertical)
                .font(.system(size: 20, weight: .regular))
                .lineLimit(5)
                .multilineTextAlignment(.leading)
                .padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
            
            Spacer()
            
            Button(action: { }) {
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
        TaskScreen()
    }
}
