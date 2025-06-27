//
//  DropDownMenu.swift
//  TodoApp
//
//  Created by Edwin Yovany on 26/06/25.
//

import SwiftUI

struct DropDownMenu: View {
    let options: [String]
    let onItemSelected: (Int) -> Void
    var buttonHeight: CGFloat = 40
    var maxItemDisplayed: Int = 5
    var width: CGFloat = 120
    
    @Binding var selectedOptionIndex: Int?
    @State private var scrollPosition: Int?
    
    public var body: some View {
        let scrollViewHeight: CGFloat = options.count > maxItemDisplayed ? (buttonHeight*CGFloat(maxItemDisplayed)) : (buttonHeight*CGFloat(options.count))

        ZStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(0..<options.count, id: \.self) { index in
                        let isSelected: Bool = index == selectedOptionIndex
                        
                        DropDownMenuItem(option: options[index],
                                        isSelected: isSelected,
                                        buttonHeight: buttonHeight) {
                            withAnimation { onItemSelected(index) }
                        }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollPosition(id: $scrollPosition)
            .scrollDisabled(options.count <= maxItemDisplayed)
            .frame(width: width, height: scrollViewHeight)
            .background(Color.secondary.opacity(0.1))
            .overlay {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.secondary, lineWidth: 1)
            }
            .onAppear {
                scrollPosition = selectedOptionIndex
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
    }
}

struct DropDownMenuItem: View {
    let option: String
    let isSelected: Bool
    let buttonHeight: CGFloat
    
    let onItemSelected: () -> Void
    
    var body: some View {
        Button(action: { onItemSelected() },
               label: {
            HStack {
                Text(option)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 8)
                    .padding(.vertical, (buttonHeight - 16) / 2)
                    .background(isSelected ? Color.gray : Color(.systemBackground))
                    .font(.system(size: 16, weight: .medium))
                    .clipShape(RoundedRectangle(cornerRadius: isSelected ? 6 : 0))
            }
            .frame(maxWidth: .infinity)
        })
        .frame(height: buttonHeight, alignment: .leading)
        .buttonStyle(.plain)
    }
}

#Preview {
    DropDownMenu(options: Category.allCases.map(\.rawValue),
                 onItemSelected: { _ in },
                 width: 150,
                 selectedOptionIndex: .constant(0))
}
