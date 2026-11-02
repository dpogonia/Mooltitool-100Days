//  Created by Dmitrii Pogonia on 21.12.2023.

import SwiftUI

class Habit: Identifiable {
    let id = UUID()
    let name: String
    var completionStatus: [Bool]
    
    init(name: String, completionStatus: [Bool]) {
        self.name = name
        self.completionStatus = completionStatus
        }
}

struct HabitsView: View {
    @State private var habits = [
        Habit(name: "Exercise", completionStatus: [false, false, false, false, false, false, false]),
        Habit(name: "Read", completionStatus: [false, false, false, false, false, false, false]),
        Habit(name: "Meditate", completionStatus: [false, false, false, false, false, false, false]),
        Habit(name: "Exercise", completionStatus: [false, false, false, false, false, false, false]),
        Habit(name: "Exercise", completionStatus: [false, false, false, false, false, false, false]),
        Habit(name: "Exercise", completionStatus: [false, false, false, false, false, false, false]),
        Habit(name: "Exercise", completionStatus: [false, false, false, false, false, false, false])
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(habits) { habit in
                    HabitRow(habit: habit)
                }
            }
            .navigationBarTitle("Habit Tracker")
        }
    }
}


struct HabitRow: View {
    @State private var isDone = false
    var habit: Habit
    
    var body: some View {
        HStack {
            Text(habit.name)
                .padding([.vertical, .trailing], 20)
                .font(.headline)
            
            Spacer()
            
            ForEach(0..<habit.completionStatus.count) { index in
                Button(action: {
                    habit.completionStatus[index].toggle()
                }) {
                    Image(systemName: habit.completionStatus[index] ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(habit.completionStatus[index] ? .green : .gray)
                }
            }
        }
    }
}




#Preview {
    HabitsView()
}
