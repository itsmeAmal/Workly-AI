//
//  OnboardingScreen 3.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-01.
//



import SwiftUI

struct OnboardingScreen_Three: View {
    @State private var email: String = ""
    
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.11, green: 0.17, blue: 0.29)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 32) {
                Spacer().frame(height: 60)
                
                // Heading
                Text("How can we\nreach you?")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                // Subheading
                Text("Your email helps us keep you updated.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.8))
                
                Spacer().frame(height: 10)
                
                // Email TextField
                TextField("Enter your email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
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

struct OnboardingScreen_Three_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen_Three()
    }
}
