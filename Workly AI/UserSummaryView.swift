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

//    private var dobString: String {
//        dob.formatted(date: .abbreviated, time: .omitted)
//    }

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
            
            Button(action: {}) {
                Text("Let's Go 🚀")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .padding()
        
        VStack(spacing: 24) {
            Label(name,  systemImage: "person.fill")
            Label(email, systemImage: "envelope.fill")
            Label(dob, systemImage: "calendar")
            //Label(contactNo, systemImage: "phone")
        }
        .font(.title3)
        .padding()
        .navigationTitle("Your Details")
        .navigationBarBackButtonHidden(true)
    }
}





struct UserSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        UserSummaryView(name: "abcd", email: "abc@gmail.com", dob: "2002-10-02", contactNo: "+94767233764")
    }
}
