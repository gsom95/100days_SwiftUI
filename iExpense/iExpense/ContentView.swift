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
            SecondView()
        })
    }
}

struct SecondView: View {
    var body: some View {
        Text("Second View")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
