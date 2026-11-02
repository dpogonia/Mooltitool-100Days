import SwiftUI

struct IExpenseView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Personal Expenses")) {
                    ForEach(personalExpenses) { item in
                        ExpenseRow(item: item)
                    }
                    .onDelete(perform: removePersonalExpenses)
                }
                
                Section(header: Text("Business Expenses")) {
                    ForEach(businessExpenses) { item in
                        ExpenseRow(item: item)
                    }
                    .onDelete(perform: removeBusinessExpenses)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    func removePersonalExpenses(at offsets: IndexSet) {
        let personalItems = personalExpenses
        personalItems.indices.forEach { index in
            let item = personalItems[index]
            if let itemIndex = expenses.items.firstIndex(where: { $0.id == item.id }) {
                expenses.items.remove(at: itemIndex)
            }
        }
    }
    
    func removeBusinessExpenses(at offsets: IndexSet) {
        let businessItems = businessExpenses
        businessItems.indices.forEach { index in
            let item = businessItems[index]
            if let itemIndex = expenses.items.firstIndex(where: { $0.id == item.id }) {
                expenses.items.remove(at: itemIndex)
            }
        }
    }
}

struct ExpenseRow: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            
            Spacer()
            
            Text(item.amount, format: .currency(code: item.currencyCode))
                .amountStyle(for: item.amount)
        }
    }
}

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount, currencyCode: Locale.current.currency?.identifier ?? "USD")
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    let currencyCode: String
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

extension View {
    func amountStyle(for amount: Double) -> some View {
        if amount < 10 {
            return self.foregroundColor(.green)
        } else if amount < 100 {
            return self.foregroundColor(.orange)
        } else {
            return self.foregroundColor(.red)
        }
    }
}

#Preview {
    IExpenseView()
}
