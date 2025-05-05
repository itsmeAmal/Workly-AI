//
//  UserSummaryView.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-03.
//


import SwiftUI

struct UserSummaryView: View {
    let name: String
    let email: String
    //let dob: Date
    let dob: String
    let contactNo: String
    let educationLevel: String
    let gender: String

    @State private var goToDashboard = false

    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.green)
            
            Text("You're all set, \(name)! 🎉")
                .font(.title)
                .bold()
            
            Text("Welcome aboard! Get ready for AI-powered career guidance tailored just for you.")
                .multilineTextAlignment(.center)
                .padding()
            
            NavigationStack {
                VStack {
                    Button {
                        goToDashboard = true          // ② tap → flip the flag
                    } label: {
                        Text("Let’s Go 🚀")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
                .navigationDestination(isPresented: $goToDashboard) {
                    DashboardContentView()
                }
            }
        }
        .padding()
        
        VStack(spacing: 24) {
            Label(name,  systemImage: "person.fill")
            Label(email, systemImage: "envelope.fill")
            Label(dob, systemImage: "calendar")
            Label(contactNo, systemImage: "phone")
            Label(educationLevel, systemImage: "graduationcap")
            Label(gender, systemImage: "person.circle.fill")
        }
        .font(.title3)
        .padding()
        .navigationTitle("Your Details")
        .navigationBarBackButtonHidden(true)
    }
}


