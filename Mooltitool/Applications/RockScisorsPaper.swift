import SwiftUI

struct RSPView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    let winningMoves = ["Paper", "Scissors", "Rock"]
    
    @State private var appMove = Int.random(in: 0..<3)
    @State private var shouldWin = Bool.random()
    @State private var playerScore = 0
    @State private var timeRemaining = 60
    @State private var isTimerRunning = false
    @State private var showAlert = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text(" \(playerScore) ")
                .font(.system(size: 30, weight: .heavy))
                .padding()
                .background(Color.green)
                .foregroundColor(.black)
                .cornerRadius(20)
            Spacer()
            Image(moves[appMove])
                .resizable()
                .frame(width: 100, height: 100)
            Spacer()
            
            if shouldWin {
                Text(" WIN! ")
                    .font(.system(size: 50, weight: .heavy, design: .rounded))
                    .foregroundColor(Color("AccentColor"))
                    .frame(alignment: .center)
            } else {
                Text(" LOSE! ")
                    .font(.system(size: 50, weight: .heavy, design: .rounded))
                    .frame(alignment: .center)
            }
            Spacer()
            HStack(spacing: 20) {
                ForEach(0..<3) { index in
                    Button(action: {
                        self.moveTapped(index)
                    }) {
                        Image(self.moves[index])
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
            }
            Spacer()
            if !isTimerRunning {
                Button(action: {
                    self.startTimer()
                }) {
                    Text("Start Timer")
                        .font(.headline)
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.black)
                        .cornerRadius(20)
                }
            }
            Text("""
   \(timeRemaining)
   """)
            .font(.system(size: 30, weight: .bold, design: .rounded))
            .frame(alignment: .center)
            .background(.yellow)
            .cornerRadius(10)
            .onAppear {
                if self.isTimerRunning {
                    self.startTimer()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Game Over"),
                      message: Text("Score: \(playerScore)"),
                      dismissButton: .default(Text("OK"), action: {
                    self.resetGame()
                }))
            }
        }.preferredColorScheme(.light)
    }
    
    func moveTapped(_ index: Int) {
        if shouldWin && winningMoves[appMove] == moves[index] {
            playerScore += 1
        } else if !shouldWin && winningMoves[appMove] != moves[index] {
            playerScore += 1
        } else {
            playerScore -= 1
        }
        
        appMove = Int.random(in: 0..<3)
        shouldWin = Bool.random()
    }
    
    func startTimer() {
        timeRemaining = 60
        isTimerRunning = true
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                timer.invalidate()
                self.isTimerRunning = false
                self.showAlert = true
            }
        }
    }
    
    func resetGame() {
        playerScore = 0
        appMove = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        isTimerRunning = false
    }
}

#Preview {
    RSPView()
}
