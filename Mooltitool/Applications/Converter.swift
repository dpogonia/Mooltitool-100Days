import SwiftUI

struct ConverterView: View {
    
    @FocusState private var isFocused: Bool
    @State private var input: Double? = nil
    @State private var selectedInputUnit: MeasurementUnit = .kilometers
    // CaseIterable is a protocol in Swift that allows you to iterate over all the cases of an enumeration type. By conforming to the CaseIterable protocol, an enumeration gains a static property called allCases, which is an array containing all the cases of that enumeration.
    enum MeasurementUnit: String, CaseIterable, Identifiable {
        case centimeters
        case kilometers
        var id: String {
            self.rawValue }
    }
    
    var convertedValue: Double {
        guard let inputValue = input else {
            return 0.0 }
        let multiplierFeet: Double = 3.28084
        let multiplierMiles: Double = 0.621371
        var result: Double = 0.0
        switch selectedInputUnit {
            case .kilometers:
                result = inputValue * multiplierMiles
            case .centimeters:
                result = inputValue / 100.0 * multiplierFeet
            }
        return result
    }
    
    var formattedTotal: String {
        switch selectedInputUnit {
        case .centimeters:
            return String(format: "%.1f", convertedValue)
        case .kilometers:
            return String(format: "%.3f", convertedValue) }
    }
    
    var resultName: String {
        switch selectedInputUnit {
        case .centimeters:
            return "feet"
        case .kilometers:
            return "miles"
        }
    }
    
    var body: some View {
        Form {
            Picker("Convert from", selection: $selectedInputUnit) {
                ForEach(MeasurementUnit.allCases) { unit in
                    Text(unit.rawValue.capitalized).tag(unit) } }
            
            TextField("amount", value: $input, format: .number)
                .keyboardType(.numberPad)
                .focused($isFocused)
            
            Section(header: Text("TO \(resultName)")) {
                Text("\(formattedTotal)") } } }
}

#Preview {
    ConverterView()
}
