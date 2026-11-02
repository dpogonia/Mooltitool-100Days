import SwiftUI

struct CoinView: View {
    @State private var coin: Bool = false
    @State private var isFlipping: Bool = false
    private var randomizer: Int { Int.random(in: 1440...1620) }
    var body: some View {
        Image(systemName: coin ? "dollarsign.circle.fill" : "bitcoinsign.circle.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 250, height: 250)
            .rotation3DEffect(.degrees(isFlipping ? Double(randomizer) : 0), axis: (x: 0, y: 1, z: 0))
            .scaleEffect(isFlipping ? 1.1 : 1.0)
            .opacity(isFlipping ? 0.3 : 1.0)
            .offset(x: isFlipping ? 0 : 0, y: isFlipping ? -30 : 0)
            .animation(.easeInOut)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) { // Set the duration to 3 seconds
                    isFlipping = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        coin = Bool.random()
                        isFlipping = false
                    }
                }
            }
    }
}

struct CoinMainView: View {
    var body: some View {
        ZStack {
            Color(UIColor.lightGray).edgesIgnoringSafeArea(.all)
            CoinView()
                .preferredColorScheme(.light)
        }
    }
}

#Preview {
    CoinView()
}
