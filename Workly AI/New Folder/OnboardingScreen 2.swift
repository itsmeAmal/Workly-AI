//
//  OnboardingScreen 2.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-01.
//



import SwiftUI

struct OnboardingScreen_Two: View {
    @State private var birthDate: Date = Date()
    
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.11, green: 0.17, blue: 0.29)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 32) {
                Spacer().frame(height: 60)
                
                // Heading
                Text("When is your\nbirthday?")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                // Subheading
                Text("This helps us personalize\nyour experience.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.8))
                
                // Date Selector
                HStack {
                    Text("Select your birth date")
                        .foregroundColor(.white)
                    Spacer()
                    DatePicker("", selection: $birthDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .labelsHidden()
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(Color.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Next Button
                Button(action: {
                    // Handle next action
                }) {
                    Text("Next")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                
                Spacer().frame(height: 30)
            }
        }
    }
}

struct OnboardingScreen_Two_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen_Two()
    }
}
