//
//  InterviewDifficulty.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-01.
//



import SwiftUI

enum InterviewDifficulty: String, CaseIterable, Identifiable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    var id: Self { self }
}

struct ScreenSix: View {
    @State private var selectedDifficulty: InterviewDifficulty = .medium
    
    // Colors
    private let navColor = Color(red: 0.11, green: 0.17, blue: 0.29)
    private let sheetColor = Color(red: 0.95, green: 0.95, blue: 0.93)

    var body: some View {
        ZStack {
            navColor.edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                Spacer().frame(height: 44)
                Text("Mock Interview")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.bottom, 16)

                Spacer().frame(height: 34)

                VStack(spacing: 24) {
                    Text("Select Interview Difficulty")
                        .font(.headline)
                        .foregroundColor(navColor)

                    Picker("Difficulty", selection: $selectedDifficulty) {
                        ForEach(InterviewDifficulty.allCases) { diff in
                            Text(diff.rawValue).tag(diff)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 16)

                    // Start Interview Button with fixed width
                    Button(action: {
                        // Start interview
                    }) {
                        Text("Start Interview")
                            .font(.headline)
                            .frame(width: 200)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.vertical, 132)
                .frame(maxWidth: .infinity)
                .background(sheetColor)
                .cornerRadius(16)
                .padding(.horizontal, 16)

                Spacer()

                // Bottom Navigation Bar
                HStack {
                    InterviewTabBarItem(icon: "house", text: "Home", selected: false, highlightColor: navColor)
                    Spacer()
                    InterviewTabBarItem(icon: "bubble.left.and.bubble.right", text: "Bot Guide", selected: false, highlightColor: navColor)
                    Spacer()
                    InterviewTabBarItem(icon: "list.bullet", text: "Interview", selected: true, highlightColor: navColor)
                    Spacer()
                    InterviewTabBarItem(icon: "person.crop.circle", text: "Profile", selected: false, highlightColor: navColor)
                    Spacer()
                    InterviewTabBarItem(icon: "gearshape", text: "Settings", selected: false, highlightColor: navColor)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 24)
                .background(Color.white)
            }
        }
    }
}

// MARK: - InterviewTabBarItem
struct InterviewTabBarItem: View {
    let icon: String
    let text: String
    let selected: Bool
    let highlightColor: Color
    
    private var imageName: String {
        selected ? "\(icon).fill" : icon
    }
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: imageName)
                .font(.system(size: 20))
                .foregroundColor(selected ? highlightColor : .gray)
            Text(text)
                .font(.caption)
                .foregroundColor(selected ? highlightColor : .gray)
        }
    }
}

struct ScreenSix_Previews: PreviewProvider {
    static var previews: some View {
        ScreenSix()
    }
}
