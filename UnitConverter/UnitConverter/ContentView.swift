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
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
