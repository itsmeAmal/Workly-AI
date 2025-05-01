//
//  InterviewDifficulty 2.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-01.
//



import SwiftUI

enum InterviewDifficulty_two: String, CaseIterable, Identifiable {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    var id: Self { self }
}

struct ScreenSeven: View {
    // Sample static state
    @State private var remainingTime: TimeInterval = 4 * 60 + 25
    @State private var answerText: String = ""
    private let navColor = Color(red: 0.11, green: 0.17, blue: 0.29)
    private let sheetColor = Color(red: 0.95, green: 0.95, blue: 0.93)
    private let difficulty: InterviewDifficulty_two = .medium

    var body: some View {
        ZStack {
            navColor.edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                Spacer().frame(height: 30)
                // Empty nav bar space

                // Main card
                VStack(alignment: .leading, spacing: 16) {
                    // Difficulty label pill
                    HStack {
                        Spacer()
                            .padding(.bottom, 46)
                        Text(difficulty.rawValue)
                            .font(.subheadline)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                    }
                    .padding(.trailing, 7)  // add space on right side

                    // Timer text
                    Text("Time Remaining : \(formatTime(remainingTime))")
                        .font(.subheadline)
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 4)

                    // Progress bar (static)
                    ProgressView(value: remainingTime / (5 * 60))
                        .accentColor(navColor)
                        .frame(maxWidth: .infinity, minHeight: 28, maxHeight: 28)
                        .padding(.horizontal, 27)

                    // Question text
                    Text("Where do you see yourself in five years?")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(navColor)
                        .padding(.horizontal, 42)

                    // Answer box with send icon
                    ZStack(alignment: .topTrailing) {
                        TextEditor(text: $answerText)
                            .frame(height: 100)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )
                            .padding(.horizontal, 12)
                        Button(action: {
                            // Send answer action
                        }) {
                            Image(systemName: "paperplane.fill")
                            .font(.title3)
                            .foregroundColor(navColor)
                            .padding(.trailing, 24)
                            .padding(.top, 45)
                        }
                            
                            
                    }

                    Spacer().frame(height: 50)

                    
                    // Action buttons
                    VStack(spacing: 22) {
                        Button(action: {
                            // Next question action
                        }) {
                            Text("Next Question")
                                .font(.headline)
                                .frame(width: 200)
                                .padding()
                                .background(navColor)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        Button(action: {
                            // End interview action
                        }) {
                            Text("End Interview")
                                .font(.headline)
                                .frame(width: 200)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                    }
                    .frame(maxWidth: .infinity)   // center the buttons
                    .padding(.horizontal, 24)
                    .padding(.bottom, 76)
                }
                .background(sheetColor)
                .cornerRadius(16)
                .padding(16)

                Spacer()

                // Bottom Navigation Bar
                HStack {
                    ScreenSevenTabBarItem(icon: "house", text: "Home", selected: false, highlightColor: navColor)
                    Spacer()
                    ScreenSevenTabBarItem(icon: "bubble.left.and.bubble.right", text: "Bot Guide", selected: false, highlightColor: navColor)
                    Spacer()
                    ScreenSevenTabBarItem(icon: "list.bullet", text: "Interview", selected: true, highlightColor: navColor)
                    Spacer()
                    ScreenSevenTabBarItem(icon: "person.crop.circle", text: "Profile", selected: false, highlightColor: navColor)
                    Spacer()
                    ScreenSevenTabBarItem(icon: "gearshape", text: "Settings", selected: false, highlightColor: navColor)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 24)
                .background(Color.white)
            }
        }
    }

    private func formatTime(_ seconds: TimeInterval) -> String {
        let minutes = Int(seconds) / 60
        let secs = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, secs)
    }
}

// MARK: - Bottom Tab Bar Item for ScreenSeven
struct ScreenSevenTabBarItem: View {
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

struct ScreenSeven_Previews: PreviewProvider {
    static var previews: some View {
        ScreenSeven()
    }
}
