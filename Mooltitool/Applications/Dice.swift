//
//  Dice.swift
//  Mooltitool
//
//  Created by Dmitrii Pogonia on 27.12.2023.
//

import SwiftUI

struct DiceView: View {
    @State private var numberOfPips: Int = 6
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "die.face.\(numberOfPips).fill")
                    .resizable()
                .aspectRatio(1, contentMode: .fit)
                .foregroundStyle(.black, .white)
                .onTapGesture {
                    withAnimation {
                        numberOfPips = Int.random(in: 1...6)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 100)
            
//            Button("Roll") {
//                withAnimation {
//                    numberOfPips = Int.random(in: 1...6)
//                }
//                
//            }
//            .foregroundColor(.primary)
//            .buttonStyle(.bordered)
//            .buttonBorderShape(.capsule)
        }
    }
}

struct DiceMainView: View {
    @State private var numberOfDice: Int = 1
    
    var body: some View {
        VStack {
            Text("Dice Roller")
                .font(.largeTitle.lowercaseSmallCaps())
                .bold()
                .foregroundStyle(.black)
            
            HStack {
                ForEach(1...numberOfDice, id: \.self) {_ in
                    DiceView()
                }
            }
            .foregroundStyle(.white)
            HStack {
                Button("Remove Dice", systemImage: "minus.circle.fill") { withAnimation {
                    numberOfDice -= 1
                }
                }
                .symbolRenderingMode(.monochrome)
                .disabled(numberOfDice == 1)
                .opacity(numberOfDice == 1 ? 0.5 : 1.0)
                
                Button("Add Dice", systemImage: "plus.circle.fill") { withAnimation {
                    numberOfDice += 1
                }
                }
                .disabled(numberOfDice == 5)
                .symbolRenderingMode(.monochrome)
                .opacity(numberOfDice == 5 ? 0.5 : 1.0)
            }
            .padding()
            .labelStyle(.iconOnly)
            .font(.title)
            .foregroundStyle(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .orange))
        .tint(.white)
        
    }
}

#Preview {
    DiceMainView()
}
