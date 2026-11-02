import SwiftUI

struct AnimationView: View {
    
    // Image Appolo blurred & Appearing Balloons
    @State private var amount2 = 0.0 // управляется слайдером
    // Шашечки
    @State private var rows = 4
    @State private var columns = 4
    
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var distance = 25.0
    @State private var amount = 1.0
    @State private var hue = 0.6
    @State private var insetAmount = 50.0
    @State private var petalOffset = -20.0
    @State private var petalWidth = 100.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var showingRed = false
    @State private var showingBlue = false
    @State private var isShowing = false
    let letters = Array("Hello SUI")
    
    // Цветной прямоугольник
    @State private var colorCycle = 0.0
    // Круг с разноцветным содержимым
    @State private var colorCycle2 = 0.0
    
    var body: some View {
        VStack() {
            ScrollView {
                VStack {
                    
                    // Цветок меняющийся
                    Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                        .stroke(.red, lineWidth: 1)
                    Flower(petalOffset: petalOffset, petalWidth: petalWidth)
                    .fill(.red, style: FillStyle(eoFill: true)) }.frame(width: 300, height: 300)
                Spacer()
                Slider(value: $petalOffset, in: -40...40)
                    .padding([.horizontal, .bottom])
                Slider(value: $petalWidth, in: 0...100)
                    .padding(.horizontal)
                
                // Blurred Appolo image
                Spacer()
                Image(.apollo10)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .saturation(amount2)
                    .blur(radius: (1 - amount2) * 20)
                Slider(value: $amount2)
                    .padding()
                
                // Появляющиеся шары
                Spacer()
                ZStack {
                    Circle()
                        .fill(Color(red: 1, green: 0, blue: 0))
                        .frame(width: 200 * amount2)
                        .offset(x: -50, y: -80)
                        .blendMode(.screen)
                    Circle()
                        .fill(Color(red: 0, green: 1, blue: 0))
                        .frame(width: 200 * amount2)
                        .offset(x: 50, y: -80)
                        .blendMode(.screen)
                    Circle()
                        .fill(Color(red: 0, green: 0, blue: 01))
                        .frame(width: 200 * amount2)
                        .blendMode(.screen)
                }
                .frame(width: 300, height: 300).background(Color.mint)
                Spacer()
                
                // Шашечки
                Checkerboard(rows: rows, columns: columns)
                    .onTapGesture {
                        withAnimation(.linear(duration: 3)) {
                            rows = 8
                            columns = 16
                        }
                    }
                    .colorInvert()
                    .frame(width: UIScreen.main.bounds.width, height: 100).background(Color.black)
                Spacer()
                
                // Спирограф
                Spyrograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                    .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                    .frame(width: 300, height: 300)
                Spacer()
                
                // Слайдеры управления для Спирографа
                Text("Inner radius: \(Int(innerRadius))")
                Slider(value: $innerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                Text("Outer radius: \(Int(outerRadius))")
                Slider(value: $outerRadius, in: 10...150, step: 1)
                    .padding([.horizontal, .bottom])
                Text("Distance: \(Int(distance))")
                Slider(value: $distance, in: 1...150, step: 1)
                    .padding([.horizontal, .bottom])
                Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
                Slider(value: $amount)
                    .padding([.horizontal, .bottom])
                Text("Color")
                Slider(value: $hue)
                    .padding(.horizontal)
                Spacer()
                
                // Полукруг
                Arc(startAngle: .degrees(0), endAngle: Angle(degrees: 110), clockwise: true)
                    .stroke(.blue, lineWidth: 10)
                    .frame(width: 300, height: 300)
                Spacer()
                
                // Треугольник
                Triangle()
                    .stroke(.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .frame(width: 300, height: 300).background(Color.pink)
                Spacer()
                
                // Text framed with an Image
                Text("Hello World")
                    .frame(width: 300, height: 300)
                    .border(ImagePaint(image: Image("young"), scale: 0.2), width: 50)
                Spacer()
                
                // Трапезоид
                Trapezoid(insetAmount: insetAmount)
                    .frame(width: 200, height: 100).background(Color.white)
                    .colorInvert()
                    .onTapGesture {
                        withAnimation {
                            insetAmount = Double.random(in: 10...90)}
                    }
                Slider(value: $insetAmount)
                    .padding(.horizontal)
                
                // Магические фигуры
                Button("MAGIC") {
                    showingRed.toggle() }
                if showingRed {
                    Rectangle()
                        .fill(.red)
                        .frame(width: 200, height: 200)
                        .transition(.asymmetric(insertion: .scale, removal: .opacity))
                }
                if showingBlue {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 200, height: 200)
                        .transition(.scale)
                }
                Button("MIRACLE") {
                    showingBlue.toggle() }
                ZStack {
                    Rectangle()
                        .fill(.blue)
                        .frame(width: 100, height: 100)
                    if isShowing {
                        Rectangle()
                            .fill(.red)
                            .frame(width: 100, height: 100)
                            .transition(.pivot)
                    }
                }
                .onTapGesture {
                    withAnimation {
                        isShowing.toggle()
                    }
                }
                
                // Анимация букв
                HStack(spacing: 0) {
                    ForEach(0..<letters.count) { num in
                        Text(String(letters[num]))
                            .padding(5)
                            .font(.title)
                            .background(enabled ? .blue : .red)
                            .offset(dragAmount)
                            .animation(.default.delay(Double(num) / 20), value: dragAmount)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged {dragAmount = $0.translation}
                        .onEnded {
                            _ in
                            dragAmount = .zero
                            enabled.toggle() } )
                
                // Просто красный треугольник узкой частью вниз
                Arrow()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                
                // Прямоугольник с разноцветным содержимым
                Slider(value: $colorCycle)
                ColorCyclingRectangle(amount: colorCycle, steps: 100)
                    .frame(width: 200, height: 200)
                
                // Круг с разноцветным содержимым
                Slider(value: $colorCycle2)
                ColorCyclingCircle(amount3: colorCycle2)
                    .frame(width: 300, height: 300)
                
                
                // Треугольник из линий
                Path { path in
                    path.move(to: CGPoint(x: 200, y: 100))
                    path.addLine(to: CGPoint(x: 100, y: 300))
                    path.addLine(to: CGPoint(x: 300, y: 300))
                    path.addLine(to: CGPoint(x: 200, y: 100))
                    path.closeSubpath()
                }
                .stroke(.blue, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
            }.frame(width: UIScreen.main.bounds.width, height: .infinity)
        }
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount3: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount3), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(active: CornerRotateModifier(amount3: -90, anchor: .topLeading), identity: CornerRotateModifier(amount3: 0, anchor: .topLeading))
    }
}

struct ColorCyclingCircle: View {
    var amount3 = 0.0
    var steps = 100
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5),]),
                            startPoint: .top,
                            endPoint: .bottom), lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount3
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct Flower: Shape {
    // How much to move this petal away from the center
    var petalOffset: Double = -20
    
    // How wide to make each petal
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
        // The path that will hold all petals
        var path = Path()
        
        // Count from 0 up to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {
            // rotate the petal by the current value of our loop
            let rotation = CGAffineTransform(rotationAngle: number)
            
            // move the petal to be at the center of our view
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))
            
            // create a path for this petal using our properties plus a fixed Y and height
            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))
            
            // apply our rotation/position transformation to the petal
            let rotatedPetal = originalPetal.applying(position)
            
            // add it to our main path
            path.addPath(rotatedPetal)
        }
        
        // now send the main path back
        return path
    }
}

struct Arc: InsettableShape {
    let startAngle: Angle
    let endAngle: Angle
    let clockwise: Bool
    var insetAmount = 0.0
    
    func path(in rect: CGRect) -> Path {
        let rotationAdjustment = Angle.degrees(90)
        let modifiedStart = startAngle - rotationAdjustment
        let modifiedEnd = endAngle - rotationAdjustment
        
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
    
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
        
    }
}

struct Checkerboard: Shape {
    var rows: Int
    var columns: Int
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(Double(rows), Double(columns))
        }
        set {
            rows = Int(newValue.first)
            columns = Int(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // figure out how big each row/column needs to be
        let rowSize = rect.height / Double(rows)
        let columnSize = rect.width / Double(columns)
        
        // loop over all rows and columns, making alternating squares colored
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a rectangle here
                    let startX = columnSize * Double(column)
                    let startY = rowSize * Double(row)
                    
                    let rect = CGRect(x: startX, y: startY, width: columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}


struct Trapezoid: Shape {
    var insetAmount: Double
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}

struct ColorCyclingRectangle: View {
    var amount: Double
    var steps: Int
    
    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var hue = Double(value) / Double(steps) + amount
        
        if hue > 1 {
            hue -= 1
        }
        
        return Color(hue: hue, saturation: 1, brightness: brightness)
    }
}

struct Arrow: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Define the arrow's dimensions
        let arrowHeight = min(rect.size.width, rect.size.height) / 3
        let arrowWidth = min(rect.size.width, rect.size.height) / 2
        
        // Start from the top-center point
        let startPoint = CGPoint(x: rect.midX, y: rect.minY)
        
        // Move to the bottom-center point
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        
        // Draw the left side of the arrow
        path.addLine(to: CGPoint(x: startPoint.x - arrowWidth/2, y: startPoint.y + arrowHeight))
        
        // Draw the right side of the arrow
        path.addLine(to: CGPoint(x: startPoint.x + arrowWidth/2, y: startPoint.y + arrowHeight))
        
        // Close the path to complete the triangle
        path.closeSubpath()
        
        return path
    }
}

struct Spyrograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: Double
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount
        var path = Path()
        
        for theta in stride(from: 0, through: endPoint, by: 0.01) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        return path
    }
}

#Preview {
    AnimationView()
}


