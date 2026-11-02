import SwiftUI

struct TimerView: View {
    @State private var time: TimeInterval = 0
    @State private var isPaused = true
    @GestureState private var isLongPressing = false
    @State private var selectedFont: Font = .system(size: .infinity, weight: .bold, design: .monospaced)
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    private let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                Text(timeString(from: time))
                    .font(selectedFont)
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width, alignment: .center) // Apply scale to the frame width
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                    .lineSpacing(0)
                    .mask(LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: .clear, location: 0),
                            .init(color: .white.opacity(1), location: 0.2),
                            .init(color: .white.opacity(0.2), location: 0.95),
                            .init(color: .clear, location: 1)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                if UIDevice.current.orientation.isPortrait {
                                    return // Do nothing in portrait orientation
                                }
                                if value.magnitude > 1.5 {
                                    selectedFont = .system(size: UIScreen.main.bounds.width, weight: .bold, design: .monospaced)
                                } else if value.magnitude < 1.0 {
                                    selectedFont = horizontalSizeClass == .compact ? .system(size: 100, weight: .bold, design: .monospaced) : .system(size: 100, weight: .bold, design: .monospaced)
                                } else {
                                    selectedFont = .system(size: 100, weight: .bold, design: .monospaced)
                                }
                            }
                            .onEnded { value in
                                if UIDevice.current.orientation.isPortrait {
                                                return // Do nothing in portrait orientation
                                            }
                                if value.magnitude > 1.5 {
                                    selectedFont = .system(size: UIScreen.main.bounds.width, weight: .bold, design: .monospaced)
                                } else if value.magnitude < 1.0 {
                                    selectedFont = horizontalSizeClass == .compact ? .system(size: 100, weight: .bold, design: .monospaced) : .system(size: 100, weight: .bold, design: .monospaced)
                                } else {
                                    selectedFont = .system(size: 100, weight: .bold, design: .monospaced)
                                }
                            }
                    )
                    .onReceive(timer) { _ in
                        guard !isPaused else { return }
                        time += 0.1
                    }
            }
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        isPaused.toggle()
                    }
            )
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 1)
                    .updating($isLongPressing) { value, state, _ in
                        state = value
                    }
                    .onEnded { _ in
                        time = 0
                    }
            )
        }
        .onAppear {
            selectedFont = horizontalSizeClass == .compact ? .system(size: 100, weight: .bold, design: .monospaced) : .system(size: UIScreen.main.bounds.width, weight: .bold, design: .monospaced)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
            if UIDevice.current.orientation.isPortrait {
                selectedFont = .system(size: 100, weight: .bold, design: .monospaced)
            } else {
                selectedFont = .system(size: UIScreen.main.bounds.width, weight: .bold, design: .monospaced)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: EmptyView())
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 100 {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
        )
    }
    
    private func timeString(from time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int(time * 10) % 10
        return String(format: "%02d:%02d.%d", minutes, seconds, milliseconds)
    }
}

struct MainTimerView: View {
    var body: some View {
        TimerView()
    }
}

extension View {
    func opacityGradient() -> some View {
        self.overlay(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .clear, location: 0),
                    .init(color: .white.opacity(0.8), location: 0.2),
                    .init(color: .white.opacity(0.8), location: 0.8),
                    .init(color: .clear, location: 1)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}
#Preview {
    TimerView()
}

