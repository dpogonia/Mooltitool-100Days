//
//  TaskView.swift
//  iChoose
//
//  Created by Dmitrii Pogonia on 08.01.2024.
import SwiftUI

struct TaskView: View {
    @State private var goals = ["Цель 1", "Цель 2", "Цель 3"]
    @State private var habits = ["Привычка 1", "Привычка 2", "Привычка 3"]
    @State private var completedGoals: Set<String> = []
    @State private var completedHabits: Set<String> = []
    @State private var selectedDay = 0
    let daysOfWeek = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]

    var body: some View {
        NavigationView {
            VStack {
                Picker("Выберите день", selection: $selectedDay) {
                    ForEach(0..<daysOfWeek.count) { index in
                        Text(self.daysOfWeek[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                List {
                    Section(header: Text("Цели")) {
                        ForEach(goals, id: \.self) { goal in
                            GoalRow(goal: goal, isCompleted: completedGoals.contains(goal)) {
                                if completedGoals.contains(goal) {
                                    completedGoals.remove(goal)
                                } else {
                                    completedGoals.insert(goal)
                                }
                            }
                        }
                    }
                    
                    Section(header: Text("Привычки")) {
                        ForEach(habits, id: \.self) { habit in
                            GoalRow(goal: habit, isCompleted: completedHabits.contains(habit)) {
                                if completedHabits.contains(habit) {
                                    completedHabits.remove(habit)
                                } else {
                                    completedHabits.insert(habit)
                                }
                            }
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Трекер Целей")
            }
        }
    }
}

struct GoalRow: View {
    let goal: String
    let isCompleted: Bool
    let toggleCompletion: () -> Void
    
    var body: some View {
        Button(action: toggleCompletion) {
            HStack {
                Text(goal)
                Spacer()
                if isCompleted {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}

#Preview {
    TaskView()
}
