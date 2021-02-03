//
//  ContentView.swift
//  Animations
//
//  Created by Igor on 28.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var enabled = false

    var body: some View {
        Button("Tap Me") {
            self.enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? Color.blue : Color.red)
        .animation(.default)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
