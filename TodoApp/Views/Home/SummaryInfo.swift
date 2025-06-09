//
//  SummaryInfo.swift
//  TodoApp
//
//  Created by Edwin Yovany on 9/06/25.
//

import SwiftUI

public struct SummaryInfo: View {
    
    let containerWidth: CGFloat
    
    public var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("Lun, junio, 09, 2025")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("1 incomplete, 1 completed")
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(16)
            .frame(width: containerWidth * 0.6)
            
            ZStack{
                Circle()
                    .stroke(lineWidth: 16)
                    .foregroundStyle(Color(.systemGray5))
                
                Circle()
                    .trim(from: 0, to: 50/100)
                    .stroke(style: StrokeStyle(lineWidth: 16, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .foregroundStyle(Color.accentColor)
                
                Text("50%")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                
            }
            .padding(16)
            .frame(width: containerWidth * 0.4)
            .aspectRatio(1, contentMode: .fit)
        }
    }
}

#Preview {
    GeometryReader { geometry in
        SummaryInfo(containerWidth: geometry.size.width)
    }
}
