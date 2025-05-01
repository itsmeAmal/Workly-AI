//
//  OnboardingScreen.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-01.
//



import SwiftUI

struct OnboardingScreen_One: View {
    @State private var name: String = ""
    
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.11, green: 0.17, blue: 0.29)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 40) {
                Spacer().frame(height: 1)
                
                // App Title
                Text("Workly.AI")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Spacer().frame(height: 50)
                
                // Heading
                Text("Let’s start with\nyour name!")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                // Subheading
                Text("What should we call you?")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
                
                // Name TextField
                TextField("Enter your name", text: $name)
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

struct OnboardingScreen_One_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen_One()
    }
}

