//
//  ContentView.swift
//  iExpense
//
//  Created by Igor on 08.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet, content: {
            SecondView(name: "Some Name")
        })
    }
}

struct SecondView: View {
    var name: String

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button("Dismiss") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
