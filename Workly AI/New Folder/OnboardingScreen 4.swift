//
//  OnboardingScreen 4.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-01.
//



import SwiftUI

struct OnboardingScreen_Four: View {
    @State private var isJobSeeker: Bool = true
    
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.11, green: 0.17, blue: 0.29)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 32) {
                Spacer().frame(height: 60)
                
                // Heading
                Text("What best describes\nyou?")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                Spacer().frame(height: 5)

                // Subheading
                Text("Are you a student or a job seeker?")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(1))
                
                Spacer().frame(height: 10)
                
                // Education Level (underlined)
                Text("High School")
                    .font(.headline)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .underline(true, color: .white)
                
                Spacer().frame(height: 5)
                
                // Job Seeker Toggle
                HStack {
                    Text("I’m looking for a job")
                        .foregroundColor(.white)
                    Spacer()
                    Toggle("", isOn: $isJobSeeker)
                        .labelsHidden()
                        .toggleStyle(SwitchToggleStyle(tint: Color.green))
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Finish Button
                Button(action: {
                    // Handle finish action
                }) {
                    Text("Finish")
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

struct OnboardingScreen_Four_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreen_Four()
    }
}
