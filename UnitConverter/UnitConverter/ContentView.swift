//
//  ContentView.swift
//  UnitConverter
//
//  Created by Igor on 26.11.2020.
//

import Combine
import SwiftUI

struct ContentView: View {
    private static let units = [
        UnitLength.centimeters,
        UnitLength.meters,
        UnitLength.kilometers,
        UnitLength.feet,
        UnitLength.yards,
        UnitLength.miles,
    ]

    @State private var input1 = "0"
    @State private var input2 = "0"
    @State private var input1UnitIndex = 0
    @State private var input2UnitIndex = 1
    @State private var isInput1Editing = false
    @State private var isInput2Editing = false

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Enter numbers and choose units")) {
                    HStack {
                        TextField("", text: $input1,
                                  onEditingChanged: {
                                      isInput1Editing = $0

                                      if isInput1Editing, input1 == "0" || input1 == "0.0" {
                                          input1 = ""
                                      }
                                      if !isInput1Editing, input1 == "." || input1 == "" {
                                          input1 = "0"
                                      }
                                  },
                                  onCommit: {
                                      let input1Val = Measurement(value: Double(input1)!, unit: ContentView.units[input1UnitIndex])
                                      input2 = "\(input1Val.converted(to: ContentView.units[input2UnitIndex]).value)"
                                  })
                            .keyboardType(.decimalPad)
                            .onReceive(Just(input1), perform: { newValue in
                                let filtered = filterInputForDecimal(newValue)

                                if filtered != newValue {
                                    input1 = filtered
                                }
                            })
                            .onChange(of: input1, perform: { _ in
                                if !isInput2Editing {
                                    let input1Val = Measurement(value: Double(input1) ?? 0, unit: ContentView.units[input1UnitIndex])
                                    input2 = "\(input1Val.converted(to: ContentView.units[input2UnitIndex]).value)"
                                }
                            })

                        // .labelsHidden doesn't work
                        Picker("", selection: $input1UnitIndex) {
                            ForEach(0..<ContentView.units.count) { index in
                                Text(ContentView.units[index].symbol)
                            }
                        }
                        .onChange(of: input1UnitIndex, perform: { [input1UnitIndex] value in
                            if value == input2UnitIndex {
                                input2UnitIndex = input1UnitIndex
                            }
                        })
                    }

                    HStack {
                        TextField("", text: $input2,
                                  onEditingChanged: {
                                      isInput2Editing = $0
                                      if isInput2Editing, input2 == "0" || input2 == "0.0" {
                                          input2 = ""
                                      }
                                      if !isInput2Editing, input2 == "." || input2 == "" {
                                          input2 = "0"
                                      }
                                  },
                                  onCommit: {
                                      let input2Val = Measurement(value: Double(input2) ?? 0, unit: ContentView.units[input2UnitIndex])
                                      input1 = "\(input2Val.converted(to: ContentView.units[input1UnitIndex]).value)"
                                  })
                            .keyboardType(.decimalPad)
                            .onReceive(Just(input2), perform: { newValue in
                                let filtered = filterInputForDecimal(newValue)

                                if filtered != newValue {
                                    input2 = filtered
                                }
                            })
                            .onChange(of: input2, perform: { _ in
                                if !isInput1Editing {
                                    let input2Val = Measurement(value: Double(input2) ?? 0, unit: ContentView.units[input2UnitIndex])
                                    input1 = "\(input2Val.converted(to: ContentView.units[input1UnitIndex]).value)"
                                }
                            })

                        // .labelsHidden doesn't work
                        Picker("", selection: $input2UnitIndex) {
                            ForEach(0..<ContentView.units.count) { index in
                                Text(ContentView.units[index].symbol)
                            }
                        }
                        .onChange(of: input2UnitIndex, perform: { [input2UnitIndex] value in
                            if value == input1UnitIndex {
                                input1UnitIndex = input2UnitIndex
                            }
                        })
                    }
                }
                .textCase(.none)
            }
            .navigationBarTitle("Length converter")
        }
    }

    func filterInputForDecimal(_ newValue: String) -> String {
        var filtered = newValue.filter { "0123456789.".contains($0) }
        if let decimalPointIndex = filtered.firstIndex(of: ".") {
            while let anotherDecimalPointIndex = filtered.lastIndex(of: "."),
                  anotherDecimalPointIndex != decimalPointIndex
            {
                filtered.remove(at: anotherDecimalPointIndex)
            }
        }

        return filtered
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
