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
        .temperature: [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin],
        .length: [UnitLength.centimeters, UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles],
        .volume: [UnitVolume.cubicCentimeters, UnitVolume.cubicMeters, UnitVolume.cubicFeet, UnitVolume.cubicYards],
    ]

    @State private var currentConversion = Conversions.temperature

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
