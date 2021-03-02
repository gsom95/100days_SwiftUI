//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Igor on 02.03.2021.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
