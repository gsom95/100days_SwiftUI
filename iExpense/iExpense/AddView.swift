//
//  AddView.swift
//  iExpense
//
//  Created by Igor on 02.03.2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""

    @State private var showErrorAlert = false

    @ObservedObject var expenses: Expenses

    static let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                if let actualAmount = Int(self.amount) {
                    let item = ExpenseItem(name: self.name, type: self.type, amount: actualAmount)
                    self.expenses.items.append(item)
                    self.presentationMode.wrappedValue.dismiss()
                } else {
                    showErrorAlert = true
                }
            })
            .alert(isPresented: $showErrorAlert) {
                Alert(
                    title: Text("Error"),
                    message: Text("Amount should be an integer number!"),
                    dismissButton: .default(Text("Continue")) {
                        self.amount = ""
                    })
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
