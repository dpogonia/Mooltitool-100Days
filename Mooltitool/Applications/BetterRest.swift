
import CoreML
import SwiftUI

struct BetterRestView: View {
    @State private var wakeUP = defaultWakeTime
    @State private var sleepAmmount = 8.0
    @State private var coffeeAmmount = 1
    let coffeeAmounts = Array(0...8)
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 5
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
        
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up")) {
                    DatePicker("Please enter a time", selection: $wakeUP, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .onChange(of: wakeUP, perform: { _ in
                            calculateBedTime() })
                }
                
                Section(header: Text("Desired amount of sleep")) {
                    Stepper("\(sleepAmmount.formatted()) hours", value: $sleepAmmount, in: 4...12, step: 0.25)
                        .onChange(of: sleepAmmount, perform: { _ in
                            calculateBedTime()})
                }
                
                Section(header: Text("Daily coffee intake")) {
                    Picker(selection: $coffeeAmmount, label: Text("Number of cups")) {
                        ForEach(coffeeAmounts, id: \.self) { amount in
                            Text("\(amount) cup\(amount > 1 ? "s" : "")")
                        }
                    }.onChange(of: coffeeAmmount, perform: { _ in
                        calculateBedTime() })
                }
                
                Section(header: Text("Recommended bedtime")) { Text(alertMessage)
                }
            }
            .navigationTitle("Better rest")
            .toolbar {
                Button("Info", action: buttonPressed)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Advice"), message: Text("Sip your coffee at least four hours prior to bedtime"), dismissButton: .default(Text("Sure")))
            }
        }
    }
    func buttonPressed() {
        showingAlert = true
    }
    
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUP)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmmount, coffee: Double(coffeeAmmount))
            let sleepTime = wakeUP - prediction.actualSleep
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry there was a problem calculating your bedtime"
        }
    }
}


#Preview {
    BetterRestView()
}
