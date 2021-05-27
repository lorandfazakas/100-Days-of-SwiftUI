//
//  ContentView.swift
//  Drawing
//
//  Created by Lorand Fazakas on 2021. 05. 26..
//

import SwiftUI

struct Arrow: InsettableShape {
    private let widthRatio: CGFloat = 10
    private let heightRatio: CGFloat = 3
    
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY/heightRatio))
        path.addLine(to: CGPoint(x: rect.midX-rect.maxX/widthRatio, y: rect.maxY/heightRatio))
        path.addLine(to: CGPoint(x: rect.midX-rect.maxX/widthRatio, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX+rect.maxX/widthRatio, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX+rect.maxX/widthRatio, y: rect.maxY/heightRatio))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY/heightRatio))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        color(for: value, brightness: 1),
                        color(for: value, brightness: 0.7)
                    ]), startPoint: .top, endPoint: .bottom), lineWidth: 1)
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var lineThickness : CGFloat = 1
    @State private var colorCycle = 0.0
    
    var lineThicknesses: [CGFloat] = [5, 10, 15, 20]
    
    
    var body: some View {
        VStack {
            Arrow()
                .strokeBorder(style: StrokeStyle(lineWidth: lineThickness, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 300)
            Button("Animate border thickness") {
                withAnimation {
                    self.lineThickness = lineThicknesses.randomElement()!
                }
            }
            .padding()
            
            ColorCyclingRectangle(amount: self.colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
