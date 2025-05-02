//
//  UserSummaryView.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-03.
//


import SwiftUI

struct UserSummaryView: View {
    let name:  String
    let email: String
    let dob:   Date

    private var dobString: String {
        dob.formatted(date: .abbreviated, time: .omitted)
    }

    var body: some View {
        VStack(spacing: 24) {
            Label(name,  systemImage: "person.fill")
            Label(email, systemImage: "envelope.fill")
            Label(dobString, systemImage: "calendar")

        }
        .font(.title3)
        .padding()
        .navigationTitle("Your Details")
    }
}
