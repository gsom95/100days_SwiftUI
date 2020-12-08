//
//  ContentView.swift
//  WordScramble
//
//  Created by Igor on 08.12.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
        }
    }

    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
           let startWords = try? String(contentsOf: startWordsURL)
        {
            let allWords = startWords.components(separatedBy: "\n")
            rootWord = allWords.randomElement() ?? "silkworm"

            return
        }

        fatalError("Could not load start.txt")
    }

    func addNewWord() {
        let lowerCased = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard lowerCased.count > 0 else {
            return
        }

        // validataion here

        usedWords.insert(lowerCased, at: 0)
        newWord = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
