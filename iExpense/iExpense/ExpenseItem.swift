//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Nathan Eastwood on 16/06/2021.
//

import Foundation

/*
  Identifiable is one of the protocols built into Swift, and means “this type can be identified uniquely.”
  It has only one requirement, which is that there must be a property called id that contains a unique identifier.
*/
struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Int
}
