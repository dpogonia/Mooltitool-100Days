//
//  TasksView.swift
//  iChoose
//
//  Created by Dmitrii Pogonia on 04.01.2024.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    @State private var goal: String = ""
    @State private var numberToAdd: String = ""
    @State private var total: Int = 0
    
    var body: some View {
        VStack {
            TextField("Enter Goal", text: $goal)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Enter Number to Add", text: $numberToAdd)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: {
                addNumber()
            }, label: {
                Text("Add")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            
            Text("Total: \(total)")
                .font(.title)
                .padding()
        }
        .onAppear(perform: {
            //
        })
        .onDisappear(perform: {
            ///
        })
    }
    
    func addNumber() {
        guard let number = Int(numberToAdd) else {
            return
        }
        
        total += number
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
    }
}
