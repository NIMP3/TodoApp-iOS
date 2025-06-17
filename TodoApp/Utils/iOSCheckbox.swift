//
//  iOSCheckbox.swift
//  TodoApp
//
//  Created by Edwin Yovany on 10/06/25.
//

import SwiftUI

struct iOSCheckbox: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.primary)
                configuration.label
            }
        })
    }
}

