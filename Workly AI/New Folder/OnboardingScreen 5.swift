//
//  OnboardingScreen 5.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-01.
//



import SwiftUI

struct OnboardingScreen_Five: View {
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.11, green: 0.17, blue: 0.29)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 32) {
                Spacer().frame(height: 60)
                
                // Success Icon
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.green)
                
                // Heading
                Text("You’re all set, !")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                // Subtitle
                Text("Welcome aboard! Get ready for\nAI-Powered career guidance tailored\njust for you.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.8))
                    .padding(.horizontal, 24)
                
                Spacer()
                
                // Let's Go Button
                Button(action: {
                    // Handle finish action
                }) {
                    Text("Let’s Go")
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

struct OnboardingScreen_Five_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen_Five()
    }
}
