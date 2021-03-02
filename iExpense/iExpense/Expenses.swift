//
//  Expenses.swift
//  iExpense
//
//  Created by Igor on 02.03.2021.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
