import SwiftUI
// Меняет стиль ViewModifier
struct ProminentTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.largeTitle.bold()).foregroundColor(.white)}}

extension View {
    func prominentTitleStyle() -> some View {
        self.modifier(ProminentTitleModifier())}}

struct SecondaryTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.foregroundStyle(.white).font(.subheadline.weight(.heavy))}}

extension View {
    func secondaryTitleStyle() -> some View {
        self.modifier(SecondaryTitleModifier())}}

struct FlagGuessView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var questionCounter = 1
    @State private var isSpinning = false
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in:0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.3), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .prominentTitleStyle()
                Spacer()
                Spacer()
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .secondaryTitleStyle()
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white).font(.largeTitle.weight(.heavy))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule()).shadow(radius: 5)
                                .rotation3DEffect(.degrees(number == correctAnswer && isSpinning ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        }
                    }.alert(scoreTitle, isPresented: $showingScore) {
                            Button("Restart", action: restartGame)
                        } message: { Text("You ended the game with a score of \(userScore). Press the restart button to restart the game.")
                        }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 30)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Score: \(userScore)")
                    .prominentTitleStyle()
                Spacer()
                Text("\(scoreTitle)")
                    .secondaryTitleStyle()
            }
            .padding()
        }
    }
    
    func flagTapped(_ number: Int) { 
        withAnimation {
        isSpinning = true
    }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if number == correctAnswer {
                scoreTitle = "Correct! That's the flag of \(countries[number])"
                //scoreTitle.font CHANGE THE FONT TO GREEN
                userScore+=1
                questionCounter+=1
            } else {
                scoreTitle = "Wrong! That's the flag of \(countries[number])."
                userScore-=1
                questionCounter+=1
            }
            if questionCounter > 3 { showingScore = true }
            askQuestion()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isSpinning = false
            }
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter = 1
        userScore = 0
        showingScore = false
    }
}

#Preview {
    FlagGuessView()
}
