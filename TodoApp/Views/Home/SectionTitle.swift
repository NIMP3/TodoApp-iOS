//
//  SectionTitle.swift
//  TodoApp
//
//  Created by Edwin Yovany on 17/06/25.
//

import SwiftUI

struct SectionTitle: View {
    let title: String
    
    public var body: some View {
        Text(title)
            .font(.headline)
            .foregroundStyle(.secondary)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
    }
}

#Preview {
    SectionTitle(title: "Section Title")
}
