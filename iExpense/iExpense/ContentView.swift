//
//  ContentView.swift
//  iExpense
//
//  Created by Igor on 08.02.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
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
                    }
                }
                .onDelete(perform: removeItems)
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddExpense = true
                }, label: {
                    Image(systemName: "plus")
                }))
            .navigationBarTitle("iExpense")
            .navigationBarItems(leading: EditButton())
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
