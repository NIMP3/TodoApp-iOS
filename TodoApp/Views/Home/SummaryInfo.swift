//
//  SummaryInfo.swift
//  TodoApp
//
//  Created by Edwin Yovany on 9/06/25.
//

import SwiftUI

public struct SummaryInfo: View {
    let date: String
    let pendingTasks: Int
    let completedTasks: Int
    let totalTaks: Int
    let containerWidth: CGFloat
    
    @State private var progress: Double = 0.0
    
    public var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text(date)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(pendingTasks) incomplete, \(completedTasks) completed")
                    .font(.system(size: 16))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
            .frame(width: containerWidth * 0.6)
            
            ZStack{
                Circle()
                    .stroke(lineWidth: 16)
                    .foregroundStyle(Color(.systemGray5))
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 16, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .foregroundStyle(Color.accentColor)
                
                Text("\(Int(progress * 100))%")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
            }
            .padding(16)
            .frame(width: containerWidth * 0.4)
            .aspectRatio(1, contentMode: .fit)
            .onAppear { updateProgressBarIndicator() }
            .onChange(of: completedTasks) { _, _ in
                updateProgressBarIndicator()
            }
            .onChange(of: totalTaks) { _, _ in
                updateProgressBarIndicator()
            }
        }
    }
    
    private func updateProgressBarIndicator() {
        if(totalTaks == 0) { return }
        withAnimation(.easeInOut(duration: 0.5)) {
            progress = Double(completedTasks) / Double(totalTaks)
        }
    }
}

#Preview {
    GeometryReader { geometry in
        SummaryInfo(
            date: "May 21, 2025",
            pendingTasks: 3,
            completedTasks: 2,
            totalTaks: 5,
            containerWidth: geometry.size.width)
    }
}
