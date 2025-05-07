//
//  MockInterviewContentView.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-04-02.
//

import SwiftUI

struct MockInterviewContentView: View {
    @State private var selectedDifficulty = "Medium"
    @State private var isInterviewStarted = false
    @State private var remainingTime = 300  // Default to 5 minutes
    @State private var currentQuestionIndex = 0
    @State private var timer: Timer?
    @State private var userAnswer: String = ""

    let difficulties = ["Easy", "Medium", "Hard"]
    let questions = [
        "Tell me about yourself.",
        "What are your strengths and weaknesses?",
        "Describe a challenging project you've worked on.",
        "Where do you see yourself in five years?",
    ]

    var body: some View {
        VStack {
            if !isInterviewStarted {
                VStack {
                    Text("Select Interview Difficulty")
                        .font(.title2)
                        .bold()
                        .padding()

                    Picker("Difficulty", selection: $selectedDifficulty) {
                        ForEach(difficulties, id: \.self) { Text($0) }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    Button(action: startInterview) {
                        Text("Start Interview")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                }
            } else {
                VStack {
                    HStack {
                        Button(action: {
                            endInterview()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.blue)
                                .padding(.trailing, 4)
                            Text("Back")
                                .foregroundColor(.blue)
                        }
                        .padding()

                        Spacer()
                    }

                    Text("Mock Interview")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, -20)

                    Text("Time Remaining: \(formattedTime())")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding()

                    ProgressView(value: Double(remainingTime), total: 300)
                        .padding()

                    Text(questions[currentQuestionIndex])
                        .font(.title2)
                        .bold()
                        .padding()
                        .multilineTextAlignment(.center)

                    TextField("Type your answer here...", text: $userAnswer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button(action: nextQuestion) {
                        Text("Next Question")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()

                    Button(action: endInterview) {
                        Text("End Interview")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom)
                }
            }
        }
        .padding()
    }

    private func startInterview() {
        isInterviewStarted = true
        remainingTime = 300  // Reset timer
        currentQuestionIndex = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                endInterview()
            }
        }
    }

    private func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            userAnswer = ""
        }
    }

    private func endInterview() {
        isInterviewStarted = false
        timer?.invalidate()
        timer = nil
        userAnswer = ""
    }

    private func formattedTime() -> String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct MockInterviewContentView_Previews: PreviewProvider {
    static var previews: some View {
        MockInterviewContentView()
    }
}
