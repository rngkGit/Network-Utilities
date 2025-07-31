import SwiftUI

struct WiFiAnimationView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            ZStack {
                // Background circle to give the full look
                Circle()
                    .stroke(lineWidth: 1)
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(width: baseWidth, height: baseHeight)
                
                // Wi-Fi arcs for different signal strength levels
                Arc(startAngle: .degrees(180), endAngle: .degrees(180 + (animationValue * 90)), lineWidth: 10)
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .foregroundColor(Color.blue)
                    .frame(width: baseWidth, height: baseHeight)
                    .opacity(0.7)
                
                Arc(startAngle: .degrees(180), endAngle: .degrees(180 + (animationValue * 120)), lineWidth: 10)
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .foregroundColor(Color.blue)
                    .frame(width: baseWidth, height: baseHeight)
                    .opacity(0.5)
                
                Arc(startAngle: .degrees(180), endAngle: .degrees(180 + (animationValue * 150)), lineWidth: 10)
                    .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .foregroundColor(Color.blue)
                    .frame(width: baseWidth, height: baseHeight)
                    .opacity(0.3)
            }
            .onAppear {
                isAnimating.toggle()
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        WiFiAnimationView()
            .padding(50)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
