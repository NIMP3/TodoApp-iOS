//
//  HomeScreen.swift
//  TodoApp
//
//  Created by Edwin Yovany on 4/06/25.
//

import SwiftUI

public struct HomeScreen: View {
    public var body: some View {
        GeometryReader { geometry in
            ScrollView {
                SummaryInfo(containerWidth: geometry.size.width)
                LazyVStack {
                    ForEach(0..<2, id: \.self) { _ in
                        TaskItem()
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
            }
        }
        .navigationTitle("TodoApp")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button{
                    
                }
                label : {
                    Image(systemName: "ellipsis")
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
