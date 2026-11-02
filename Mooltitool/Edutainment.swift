import SwiftUI

struct EdutainmentView: View {
    @State private var gameIsActive = false
    @State private var selectedTable = 2
    @State private var numberOfQuestions = 5
    @State private var questionNumber = 0
    @State private var questions = [Question]()
    @State private var answerText = ""
    
    var body: some View {
        VStack {
            Text("Test")
            
            Button(action: {
                gameIsActive.toggle()
                if gameIsActive {
                    questions = generateQuestions()
                }
            }) {
                Text(gameIsActive ? "Settings" : "Start Game")
            }
            
            if gameIsActive {
                Text(questions[questionNumber].text)
                
                TextField("Answer", text: $answerText, onCommit: {
                    checkAnswer(Int(answerText) ?? 0)
                    answerText = ""
                })
            } else {
                SettingsView(selectedTable: $selectedTable, numberOfQuestions: $numberOfQuestions)
            }
        }
    }
    
    // Generate an array of questions based on the settings
    private func generateQuestions() -> [Question] {
        var questions = [Question]()
        for i in 1...numberOfQuestions {
            let questionText = "\(selectedTable) x \(i) ="
            let answer = selectedTable * i
            let question = Question(text: questionText, answer: answer)
            questions.append(question)
        }
        return questions
    }
    
    private func checkAnswer(_ answer: Int) {
        if answer == questions[questionNumber].answer {
            // Correct answer
        } else {
            // Incorrect answer
        }
        
        if questionNumber < questions.count - 1 {
            questionNumber += 1
        } else {
            questionNumber = 0
            gameIsActive = false
        }
    }
}

struct Question {
    let text: String
    let answer: Int
}

struct SettingsView: View {
    @Binding var selectedTable: Int
    @Binding var numberOfQuestions: Int
    
    var body: some View {
        VStack {
            Stepper(value: $selectedTable, in: 2...12) {
                Text("Multiplication Table: \(selectedTable)")
            }
            
            Picker("Number of Questions", selection: $numberOfQuestions) {
                Text("5").tag(5)
                Text("10").tag(10)
                Text("20").tag(20)
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}
