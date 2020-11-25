//
//  ContentView.swift
//  WeSplit
//
//  Created by Igor on 25.11.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var stringNumberOfPeople = "4"
    @State private var tipPercentage = 2

    let tipPercentages = [0, 10, 15, 20, 25]

    var totalAmount: Double {
        let selectedTipPercentage = Double(tipPercentages[tipPercentage])
        let enteredCheckAmount = Double(checkAmount) ?? 0

        let tip = enteredCheckAmount / 100 * selectedTipPercentage

        return enteredCheckAmount + tip
    }

    var numberOfPeople: Double {
        return Double(stringNumberOfPeople) ?? 0
    }

    var totalPerPerson: Double {
        let peopleCount = numberOfPeople
        let amountPerPerson = totalAmount / peopleCount

        return amountPerPerson
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)

                    TextField("Number of people", text: $stringNumberOfPeople)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                // Why on Earth would anyonee want an all-caps header? #iOS 14 solution
                .textCase(nil)

                Section(header: Text("Total amount")) {
                    Text("$\(totalAmount, specifier: "%.2f")")
                }

                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                // Also works
                .textCase(.none)
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
