//
//  WiFiAnimationView.swift
//  Network Utilities
//
//  Created by Keith Beavers on 4/2/25.
//


import SwiftUI

struct WiFiAnimationView: View {
    @State private var animationValue: CGFloat = 0.0
    
    let baseWidth: CGFloat = 120
    let baseHeight: CGFloat = 60
    
    var body: some View {
        VStack {
            ZStack {
                // First arc (bottom-most)
                Arc(startAngle: .degrees(180+45), endAngle: .degrees(180 + 45 + Double(animationValue * 90)), lineWidth: 10)
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .foregroundColor(Color.blue)
                    .frame(width: baseWidth, height: baseHeight)
                    .opacity(0.7)
                    .offset(y: baseHeight * 0.2)  // Move the arc upward
                
                // Second arc (middle)
                Arc(startAngle: .degrees(180+45), endAngle: .degrees(180 + 45 + Double(animationValue * (90))), lineWidth: 20)
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .foregroundColor(Color.blue)
                    .frame(width: baseWidth*1.5, height: baseHeight*2)
                    .opacity(0.5)
                    .offset(y: baseHeight * 0.1)  // Move it a bit higher
                
                // Third arc (top-most)
                Arc(startAngle: .degrees(180+45), endAngle: .degrees(180 + 45 + Double(animationValue * (90))), lineWidth: 20)
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .foregroundColor(Color.blue)
                    .frame(width: baseWidth*2, height: baseHeight*3)
                    .opacity(0.3)
                    .offset(y: 0)  // This stays at the top position
            }
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1.3)) {
                    animationValue = 1.0 // Full signal strength
                }
            }
        }
    }
}

struct Arc: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var lineWidth: CGFloat
    
    var animatableData: CGFloat {
        get { endAngle.degrees }
        set { endAngle = Angle(degrees: newValue) }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        return path
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
