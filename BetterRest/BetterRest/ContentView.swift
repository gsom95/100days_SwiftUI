//
//  ContentView.swift
//  BetterRest
//
//  Created by Igor on 02.12.2020.
//

import SwiftUI

struct ContentView: View {
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("When do you want to wake up?").textCase(.none)) {
                    DatePicker("Wake up time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                }

                Section(header: Text("Desired amount of sleep").textCase(.none)) {
                    Stepper(value: $sleepAmount, in: 4 ... 12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours of sleep")
                    }
                }

                Section(header: Text("Daily coffee intake").textCase(.none)) {
                    Stepper(value: $coffeeAmount, in: 1 ... 20) {
                        Text("\(coffeeAmount) cup\(coffeeAmount == 1 ? "" : "s")")
                    }
                }

                Section(header: Text("Your ideal bedtime").textCase(.none)) {
                    Text(calculateBedtime())
                }
            }
            .navigationBarTitle("BetterRest")
        }
    }

    func calculateBedtime() -> String {
        let model = SleepCalculator()

        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))

            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: sleepTime)
        } catch {
            return "Problem calculating your bedtime :("
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
