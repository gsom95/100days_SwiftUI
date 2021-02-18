//
//  ContentView.swift
//  iExpense
//
//  Created by Igor on 08.02.2021.
//

import SwiftUI

struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    @State private var user = User(firstName: "Taylor", lastName: "Swift")

    var body: some View {
        VStack {
            Button("Save User") {
                let encoder = JSONEncoder()

                let newUser = User(firstName: "Dune", lastName: "Emperor")

                if let data = try? encoder.encode(newUser) {
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }

            Button("Load User") {
                let decoder = JSONDecoder()

                if let userData = UserDefaults.standard.data(forKey: "UserData"),
                   let user = try? decoder.decode(User.self, from: userData)
                {
                    self.user = user
                }
            }

            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
