//
//  OnboardUserContentView.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-04-03.
//

import SwiftUI

struct OnboardUserContentView: View {
    @State private var currentStep = 0
    @State private var name = ""
    @State private var contactNo = ""
    @State private var dob = ""
    @State private var dateOfBirth = Date()
    @State private var email = ""
    @State private var educationLevel = "High School"
    @State private var isJobSeeker = false
    @State private var gender = "Male"

    @State private var showSummary = false

    let educationOptions = ["High School", "Diploma",
                            "Bachelor's", "Master's", "PhD"]
    private let genderOptions = ["Male", "Female", "Other"]
    

    @Environment(\.dismiss) private var dismiss
    var onFinish: () -> Void = {}

    var body: some View {
        NavigationStack {
            ZStack {
                // gradient backdrop to match other screens
                LinearGradient(
                    colors: [Color(#colorLiteral(red:0.16, green:0.28, blue:0.62, alpha:1)),
                             Color(#colorLiteral(red:0.46, green:0.27, blue:0.75, alpha:1))],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                // the step content
                VStack {
                    currentStepView        // unchanged logic
                }
                .animation(.easeInOut, value: currentStep)
                .padding(.vertical, 40)
            }
            .navigationDestination(isPresented: $showSummary) {
                UserSummaryView(
                    name: name,
                    email: email,
                    dob: dob,
                    contactNo: contactNo,
                    educationLevel: educationLevel,
                    gender: gender
                )
            }
        }
    }

    // just extracts the existing if‑ladder for clarity; nothing else changes
    @ViewBuilder
    private var currentStepView: some View {
        if currentStep == 0 {
            StepView(
                title: "Let's start with your name! 😊",
                subtitle: "What should we call you?",
                content: AnyView(
                    TextField("Enter your full name", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                ),
                actionTitle: "Next",
                action: { nextStep() }
            )
        } else if currentStep == 1 {
            StepView(
                title: "Tell us your gender ⚧️",
                subtitle: "Optional, but helps us personalize things.",
                content: AnyView(
                    Picker("Gender", selection: $gender) {
                        ForEach(genderOptions, id: \.self) { Text($0) }
                    }
                        .pickerStyle(.segmented)
                        .padding()
                ),
                actionTitle: "Finish",
                action: { nextStep() }
            )
        } else if currentStep == 2 {
            StepView(
                title: "When is your birthday? 🎂",
                subtitle: "This helps us personalize your experience.",
                content: AnyView(
                    DatePicker("Select your birth date",
                               selection: $dateOfBirth,
                               displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                ),
                actionTitle: "Next",
                action: { nextStep() }
            )
        } else if currentStep == 3 {
            StepView(
                title: "How can we reach you? 📧",
                subtitle: "Your email helps us keep you updated.",
                content: AnyView(
                    TextField("Enter your email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                        .padding()
                ),
                actionTitle: "Next",
                action: { nextStep() }
            )
        } else if currentStep == 4 {
            StepView(
                title: "What's your Contact Number? ☎️",
                subtitle: "Your phone helps us keep you updated.",
                content: AnyView(
                    TextField("Enter your Contact No", text: $contactNo)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                ),
                actionTitle: "Next",
                action: { nextStep() }
            )
        } else if currentStep == 5 {
            StepView(
                title: "What best describes you? 🎓💼",
                subtitle: "Are you a student or a job seeker?",
                content: AnyView(
                    VStack {
                        Picker("Select your education level",
                               selection: $educationLevel) {
                            ForEach(educationOptions, id: \.self) { Text($0) }
                        }
                        .pickerStyle(.menu)
                        .padding()

                        Toggle("I'm looking for a job", isOn: $isJobSeeker)
                            .padding()
                    }
                ),
                actionTitle: "Finish",
                action: {
                    guard !name.isEmpty, !email.isEmpty, !contactNo.isEmpty else { return }

                    DBManager.shared.insert(
                        name: name,
                        dob: dateOfBirth,
                        email: email,
                        contactNo: contactNo,
                        educationLevel: educationLevel,
                        gender: gender,
                        isJobSeeker: isJobSeeker
                    )
                    onFinish()
                    showSummary = true    // trigger navigation
                }
            )
        }
    }

    
    

    private func nextStep() { currentStep += 1 }
}




struct StepView: View {
    var title: String
    var subtitle: String
    var content: AnyView
    var actionTitle: String
    var action: () -> Void

    var body: some View {
        VStack(spacing: 28) {
            // headline
            VStack(spacing: 12) {
                Text(title)
                    .font(.title2.weight(.bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)

                Text(subtitle)
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white.opacity(0.9))
                    .padding(.horizontal, 12)
            }

            // dynamic control(s)
            content

            // action button
            Button(actionTitle, action: action)
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity)
        }
        .padding(32)
        .background(.thinMaterial)        // glassy card
        .cornerRadius(24)
        .shadow(radius: 10, y: 4)
        .padding(.horizontal, 24)
    }
}


