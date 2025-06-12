//
//  TaskItem.swift
//  TodoApp
//
//  Created by Edwin Yovany on 10/06/25.
//

import SwiftUI

public struct TaskItem: View {
    @State private var isOn = false
    
    public var body: some View {
        VStack(alignment: .trailing){
            HStack{
                Toggle(isOn: $isOn){}
                    .toggleStyle(iOSCheckbox())
                    .padding(6)
                
                VStack(alignment: .leading){
                    Text("I need to send my personal CV.")
                        .font(.headline)
                        .foregroundStyle(.primary)
                        .fontWeight(.medium)
                        .padding(.bottom, 4)
                    
                    Text("I need to send my personal CV because I want to apply for a new job.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                Image(systemName: "trash.fill")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.primary)
                    .padding(6)
            }
            .padding(EdgeInsets(top: 12, leading: 12, bottom: 8, trailing: 12))
            
            Text("PERSONAL")
                .font(.footnote)
                .foregroundStyle(.white)
                .fontWeight(.medium)
                .padding(6)
                .background(.cyan)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(12)
        }
        .background(.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .padding(12)
    }
}

#Preview {
    TaskItem()
}
