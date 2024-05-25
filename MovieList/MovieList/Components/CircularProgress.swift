//
//  CircularProgress.swift
//  MovieList
//
//  Created by JASS on 25/05/24.
//

import SwiftUI

struct CircularProgress: View {
    
    let progress: Double
    let radius: CGFloat = 30
    let barWidth: CGFloat = 3
    let sizeFont: CGFloat = 8
    private var colorBar: Color {
        switch (progress) {
        case 0.4..<0.7:
            Color.yellow
        case ..<0.4:
            Color.red
        default:
            Color.green
        }
    }
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .stroke(
                    Color.black,
                    lineWidth: (barWidth*2)
                )
                .background(
                    Circle()
                )
            
            Circle()
                .stroke(
                    Color.gray.opacity(0.5),
                    lineWidth: barWidth
                )
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    colorBar,
                    style: StrokeStyle(
                        lineWidth: barWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
            
            Text("\(Int(progress*100))%")
                .font(.system(size: sizeFont, weight: .bold))
                .foregroundColor(Color.white)
            
        }.frame(width: radius, height: radius)
    }
}

#Preview {
    CircularProgress(progress: 0.8)
}
