//
//  ScreenThree.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-01.
//


import SwiftUI

struct ScreenThree: View {
    var body: some View {
        ZStack {
            Color(red: 0.11, green: 0.17, blue: 0.29)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                // Header
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.top, 10)
                
                // Personal Details Card
                VStack(alignment: .leading, spacing: 16) {
                    Text("PERSONAL DETAILS")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.leading, 16)
                    VStack(spacing: 0) {
                        InfoRow(label: "Full Name", value: "John Doe")
                        Divider().background(Color.gray.opacity(0.3))
                        InfoRow(label: "Date of Birth", value: "January 1, 1990")
                        Divider().background(Color.gray.opacity(0.3))
                        InfoRow(label: "Gender", value: "Male")
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    
                }
                .padding(.horizontal, 24)
                
                
                Spacer().frame(height: 10)
                
                
                // Education & Contact Card
                VStack(alignment: .leading, spacing: 16) {
                    Text("EDUCATION & CONTACT")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.leading, 16)
                    VStack(spacing: 0) {
                        InfoRow(label: "Higher Education level", value: "Bachelor’s Degree")
                        Divider().background(Color.gray.opacity(0.3))
                        InfoRow(label: "Contact Number", value: "+94711023694")
                        Divider().background(Color.gray.opacity(0.3))
                        InfoRow(label: "Email", value: "johndoe@gmail.com", valueColor: .blue)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Edit Profile Button
                Button(action: {
                    // Handle edit profile
                }) {
                    Text("Edit Profile")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 24)
                
                // Tab Bar
                VStack(spacing: 0) {
                    Divider()
                        .background(Color.gray.opacity(0.3))
                    HStack {
                        Spacer()
                        TabBarItem(icon: "house", text: "Home", selected: false)
                        Spacer()
                        TabBarItem(icon: "bubble.left.and.bubble.right", text: "Bot Guide", selected: false)
                        Spacer()
                        TabBarItem(icon: "list.bullet", text: "Interview", selected: false)
                        Spacer()
                        TabBarItem(icon: "person", text: "Profile", selected: true)
                        Spacer()
                        TabBarItem(icon: "gearshape", text: "Settings", selected: false)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background(Color.white)
                }
            }
        }
    }
}

// MARK: - InfoRow
struct InfoRow: View {
    let label: String
    let value: String
    var valueColor: Color = Color(red: 0.11, green: 0.17, blue: 0.29)
    
    var body: some View {
        HStack {
            Text("\(label):")
                .font(.subheadline)
                .foregroundColor(Color(red: 0.11, green: 0.17, blue: 0.29))
            Text(value)
                .font(.subheadline)
                .foregroundColor(valueColor)
            Spacer()
        }
        .padding(.all, 16)
    }
}

// MARK: - TabBarItem
struct TabBarItem: View {
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
struct ScreenThree_Previews: PreviewProvider {
    static var previews: some View {
        ScreenThree()
    }
}
