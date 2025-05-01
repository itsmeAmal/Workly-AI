//
//  ScreenTwo.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-01.
//


import SwiftUI

struct ScreenTwo: View {
    var body: some View {
        ZStack {
            // Background Color
            Color(red: 0.11, green: 0.17, blue: 0.29)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 16) {
                // Header
                HStack {
                    Text("Workly.AI")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                    Text("John Doe")
                        .font(.title2)
                        .foregroundColor(.white)
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 24)
                .padding(.top, 60)
                
                Spacer().frame(height: 5)

                // Top Cards
                HStack(spacing: 16) {
                    CardView(title: "Mock Interviews Passed", value: "5", subtitle: nil)
                    CardView(title: "Questions Answered", value: "20", subtitle: nil)
                }
                .padding(.horizontal, 24)
                
                // Middle Card
                CardView(title: "Chatbot Interactions", value: "35", subtitle: nil)
                    .frame(height: 120)
                    .padding(.horizontal, 24)
                
                // Career Status Card with increased height
                CardView(title: "Career Status", value: nil, subtitle: "Track your career progress with AI insights")
                    .frame(height: 140)
                    .padding(.horizontal, 24)
                
                Spacer()
                
                // Page Indicator
                HStack(spacing: 8) {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.gray)
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.gray)
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(.gray)
                }
                
                // Tab Bar
                HStack {
                    Spacer()
                    TabItem(icon: "house.fill", text: "Home", selected: true)
                    Spacer()
                    TabItem(icon: "bubble.left.and.bubble.right", text: "Bot Guide", selected: false)
                    Spacer()
                    TabItem(icon: "list.bullet", text: "Interview", selected: false)
                    Spacer()
                    TabItem(icon: "person", text: "Profile", selected: false)
                    Spacer()
                    TabItem(icon: "gearshape", text: "Settings", selected: false)
                    Spacer()
                }
                .padding(.vertical, 8)
                .background(Color.white)
            }
        }
    }
}

// MARK: - CardView
struct CardView: View {
    let title: String
    let value: String?
    let subtitle: String?
    
    var body: some View {
        VStack(spacing: 8) {
            if let value = value {
                Text(value)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.11, green: 0.17, blue: 0.29))
                Text(title)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.11, green: 0.17, blue: 0.29))
            } else if let subtitle = subtitle {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.11, green: 0.17, blue: 0.29))
                Text(subtitle)
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.11, green: 0.17, blue: 0.29))
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

// MARK: - TabBarItem
struct TabItem: View {
    let icon: String
    let text: String
    let selected: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(selected ? Color.black : .gray)
            Text(text)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(selected ? Color.black : .gray)
        }
    }
}

// MARK: - Preview
struct ScreenTwo_Previews: PreviewProvider {
    static var previews: some View {
        ScreenTwo()
    }
}
