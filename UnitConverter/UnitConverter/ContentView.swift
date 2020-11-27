//
//  ContentView.swift
//  UnitConverter
//
//  Created by Igor on 26.11.2020.
//

import SwiftUI

enum Conversions: String, Equatable, CaseIterable {
    case temperature
    case length
    case volume
}

struct ContentView: View {
    let conversionToUnits: [Conversions: [Unit]] = [
        .temperature: [
            UnitTemperature.celsius,
            UnitTemperature.fahrenheit,
            UnitTemperature.kelvin,
        ],
        .length: [
            UnitLength.centimeters,
            UnitLength.meters,
            UnitLength.kilometers,
            UnitLength.feet,
            UnitLength.yards,
            UnitLength.miles,
        ],
        .volume: [
            UnitVolume.cubicCentimeters,
            UnitVolume.cubicMeters,
            UnitVolume.cubicFeet,
            UnitVolume.cubicYards,
        ],
    ]

    @State private var currentConversion = Conversions.temperature
    @State private var input1 = ""
    @State private var input2 = ""
    @State private var unit1Type: Unit = UnitTemperature.celsius
    @State private var unit2Type: Unit = UnitTemperature.fahrenheit

    var body: some View {
        NavigationView {
            HStack {
                Form {
                    Section(header: Text("Choose what type of conversion you want")) {
                        Picker("Conversion type", selection: $currentConversion) {
                            ForEach(Conversions.allCases, id: \.self) { val in
                                Text(val.rawValue.capitalized)
                                    .tag(val)
                            }
                        }
                        .onChange(of: currentConversion) { _ in
                            unit1Type = conversionToUnits[currentConversion]![0]
                            unit2Type = conversionToUnits[currentConversion]![1]
                        }
                    }
                    .textCase(.none)

                    Section(header: Text("Enter numbers and choose units")) {
                        HStack {
                            TextField("Unit 1", text: $input1)
                                .keyboardType(.decimalPad)

                            // .labelsHidden doesn't work
                            Picker("", selection: $unit1Type) {
                                ForEach(conversionToUnits[currentConversion]!, id: \.self) { unit in
                                    Text(unit.symbol)
                                }
                            }
                        }

                        HStack {
                            TextField("Unit 2", text: $input2)
                                .keyboardType(.decimalPad)

                            // .labelsHidden doesn't work
                            Picker("", selection: $unit2Type) {
                                ForEach(conversionToUnits[currentConversion]!, id: \.self) { unit in
                                    Text(unit.symbol)
                                }
                            }
                        }
                    }
                    .textCase(.none)
                }
            }
            .navigationBarTitle("Unit converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
