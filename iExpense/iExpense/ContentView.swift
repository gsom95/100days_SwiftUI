//
//  ContentView.swift
//  iExpense
//
//  Created by Igor on 08.02.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarItems(trailing:
                Button(action: {
                    let expense = ExpenseItem(name: "test", type: "Personal", amount: 5)
                    self.expenses.items.append(expense)
                }, label: {
                    Image(systemName: "plus")
                }))
            .navigationBarTitle("iExpense")
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
