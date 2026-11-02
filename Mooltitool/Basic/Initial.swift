import SwiftUI

struct InitialView: View {
    @State private var gridColumns = 3
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridLayout(), spacing: 16) {
                    
                    NavigationLink(destination: WeSplitView()) {
                        styledText("WeSplit")
                    }
                    
                    NavigationLink(destination: ConverterView()) {
                        styledText("Converter")
                    }
                    
                    NavigationLink(destination: RGBView()) {
                        styledText("RGB")
                    }
                    
                    NavigationLink(destination: FlagGuessView()) {
                        styledText("FlagGuess")
                    }
                    
                    NavigationLink(destination: RSPView()) {
                        styledText("RockScissorsPaper")
                    }
                    
                    NavigationLink(destination: BetterRestView()) {
                        styledText("BetterRest")
                    }
                    
                    NavigationLink(destination: WordScrambleView()) {
                        styledText("WordScramble")
                    }
                    
                    NavigationLink(destination: IExpenseView()) {
                        styledText("iExpense")
                    }
                
                    
                    NavigationLink(destination: MoonmanView()) {
                        styledText("Moonman")
                    }
                    
                    NavigationLink(destination: AnimationView()) {
                        styledText("Animation")
                    }
                    
                    NavigationLink(destination: HabitoView()) {
                        styledText("Habito")
                    }
                    
                    NavigationLink(destination: CoinMainView()) {
                        styledText("Coin")
                    }
                    
                    NavigationLink(destination: TimerView().navigationBarBackButtonHidden(true)) {
                        styledText("Timer")
                    }
                    
                    NavigationLink(destination: BookwormView()) {
                        styledText("Bookworm")
                    }
                    
                    NavigationLink(destination: FlashzillaView()) {
                        styledText("Flashzilla")
                    }
                    
                    NavigationLink(destination: SnowSeekerView()) {
                        styledText("SnowSeeker")
                    }
                    
                    NavigationLink(destination: tabView()) {
                        styledText("WelcomePage")
                    }
                    
                    NavigationLink(destination: DiceMainView()) {
                        styledText("Dice")
                    }
                    
                    NavigationLink(destination: MainView()) {
                        styledText("Life")
                    }
                }
            }
            .padding(.trailing)
            .navigationTitle("MOOLTITOOL")
            .font(.title3)
            .onAppear {
                calculateGridColumns()
            }
            .background(Color.gray)
        }
    }
    
    func gridLayout() -> [GridItem] {
        Array(repeating: .init(.flexible()), count: gridColumns)
    }
    
    func calculateGridColumns() {
        let screenWidth = UIScreen.main.bounds.width
        let minItemWidth: CGFloat = 100 // Minimum width for each button
        let spacing: CGFloat = 10 // Spacing between buttons
        
        let availableWidth = screenWidth - (spacing * CGFloat(gridColumns - 1))
        let maxColumns = Int(availableWidth / minItemWidth)
        
        gridColumns = maxColumns > 0 ? maxColumns : 1
    }
    
    func styledText(_ text: String) -> some View {
        Text(text)
            .frame(width: 100, height: 60, alignment: .center)
            .font(.headline)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(10)
            .minimumScaleFactor(0.5)
            .padding(0.2)
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail View")
    }
}
