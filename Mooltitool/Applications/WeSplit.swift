//  Created by Dmitrii Pogonia on 16.09.2023.

import SwiftUI

struct WeSplitView: View {
    @State private var checkAmount: Double? = nil
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @State private var calculateForOnePerson = false
    // устанавливает фокус на поле TextField
    @FocusState private var amountIsFocused: Bool
    let currencyType: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    let tipPercentages = [0, 2, 3, 5, 7, 10, 15]
    var totalPerPerson: Double {
        guard let checkAmountX = checkAmount else {
            return 0
        }
        
        let peopleCount = calculateForOnePerson ? 1 : Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmountX / 100 * tipSelection
        let grandTotal = checkAmountX + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var totalCheck: Double {
        guard let checkAmountX = checkAmount else {
            return 0
        }
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmountX / 100 * tipSelection
        let grandTotal = checkAmountX + tipValue
        
        return grandTotal
    }
    
    var body: some View {
            Form {
                Section {
                    TextField("0 RUB", value: $checkAmount, format: .number)
                        .keyboardType(.numberPad) //.decimalPad
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<11) { number in
                            Text("\(number) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) { percentage in
                            Text("\(percentage)%")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Toggle("Calculate for one person", isOn: $calculateForOnePerson)
                        
                }
                
                Section(header: Text("Total amount for the check")) {
                    Text(totalCheck, format: currencyType)
                }.foregroundColor(tipPercentage == 0 ? Color.red : Color.primary)
                
                Section(header: Text("Amount per person")) {
                    Text(totalPerPerson, format: currencyType)
                }
            .navigationTitle("We split")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    }
                ToolbarItem(placement: .keyboard) {
                        Button("Done") {
                            amountIsFocused = false
                        }
                }
            }
        }
    }
}


#Preview {
    WeSplitView()
}
