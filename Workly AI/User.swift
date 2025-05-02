//
//  User.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-02.
//


import Foundation

//struct User: Identifiable {
//    let id: Int32          // SQLite INTEGER PRIMARY KEY
//    var name: String
//    var age: Int
//}


struct User: Identifiable {
    let id: Int32
    var name: String
    var dob: Date         // NEW
    var email: String     // NEW
}
