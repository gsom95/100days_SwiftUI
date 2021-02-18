//
//  ContentView.swift
//  iExpense
//
//  Created by Igor on 08.02.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)

                    Button("Add number") {
                        self.numbers.append(self.currentNumber)
                        self.currentNumber += 1
                    }
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }

    func removeRows(at offests: IndexSet) {
        numbers.remove(atOffsets: offests)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
