//
//  ContentView.swift
//  iExpense
//
//  Created by Lorand Fazakas on 2021. 04. 29..
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showindAddExpense = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }

                                Spacer()
                                Text("$\(item.amount)")
                                    .foregroundColor(expenseCategoryColor(for: item.amount))
                            }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton(), trailing:
                Button(action: {
                    self.showindAddExpense = true
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showindAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func expenseCategoryColor(for amount: Int) -> Color {
        switch amount {
        case 1..<10:
            return Color.green
        case 10..<100:
            return Color.orange
        default:
            return Color.red
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
