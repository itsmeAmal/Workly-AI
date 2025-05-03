//
//  OnboardUserContentView.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-04-03.
//


//import SwiftUI
//
//struct OnboardUserContentView: View {
//    @State private var currentStep = 0
//    @State private var name = ""
//    @State private var dateOfBirth = Date()
//    @State private var email = ""
//    @State private var educationLevel = "High School"
//    @State private var isJobSeeker = false
//    
//    @State private var showSummary = false
//    
//    let educationOptions = ["High School", "Diploma", "Bachelor's", "Master's", "PhD"]
//    
//    
//    @Environment(\.dismiss) private var dismiss
//    
//    var onFinish: () -> Void
//    
//    var body: some View {
//        VStack {
//            if currentStep == 0 {
//                StepView(
//                    title: "Let's start with your name! 😊",
//                    subtitle: "What should we call you?",
//                    content: AnyView(TextField("Enter your full name", text: $name)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding()),
//                    actionTitle: "Next",
//                    action: { nextStep() }
//                )
//            } else if currentStep == 1 {
//                StepView(
//                    title: "When is your birthday? 🎂",
//                    subtitle: "This helps us personalize your experience.",
//                    content: AnyView(DatePicker("Select your birth date", selection: $dateOfBirth, displayedComponents: .date)
//                        .datePickerStyle(CompactDatePickerStyle())
//                        .padding()),
//                    actionTitle: "Next",
//                    action: { nextStep() }
//                )
//            } else if currentStep == 2 {
//                StepView(
//                    title: "How can we reach you? 📧",
//                    subtitle: "Your email helps us keep you updated.",
//                    content: AnyView(TextField("Enter your email", text: $email)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .keyboardType(.emailAddress)
//                        .padding()),
//                    actionTitle: "Next",
//                    action: { nextStep() }
//                )
//            } else if currentStep == 3 {
//                StepView(
//                    title: "What best describes you? 🎓💼",
//                    subtitle: "Are you a student or a job seeker?",
//                    content: AnyView(VStack {
//                        Picker("Select your education level", selection: $educationLevel) {
//                            ForEach(educationOptions, id: \.self) { Text($0) }
//                        }
//                        .pickerStyle(MenuPickerStyle())
//                        .padding()
//
//                        Toggle("I'm looking for a job", isOn: $isJobSeeker)
//                            .padding()
//                    }),
//                    actionTitle: "Finish",
//                    //action: { nextStep() }
//                    action: {
//                        guard !name.isEmpty, !email.isEmpty else { return }
//                        DBManager.shared.insert(name: name,
//                                                dob: dateOfBirth,
//                                                email: email
//                        )
//                    }
//                    
//                )
//                
//            } else {
//                // 🎉 Final Welcome Screen
//                VStack(spacing: 20) {
//                    Image(systemName: "checkmark.circle.fill")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 80, height: 80)
//                        .foregroundColor(.green)
//                    
//                    Text("You're all set, \(name)! 🎉")
//                        .font(.title)
//                        .bold()
//                    
//                    Text("Welcome aboard! Get ready for AI-powered career guidance tailored just for you.")
//                        .multilineTextAlignment(.center)
//                        .padding()
//                    
//                    Button(action: {
////                        onFinish()
////                        dismiss()
//                        guard !name.isEmpty, !email.isEmpty else { return }
////                        DBManager.shared.insert(name: name,
////                                                dob: dateOfBirth,
////                                                email: email
////                        )
//                            onFinish()
//                            showSummary = true
//                            //dismiss()
//                    }) {
//                        Text("Let's Go 🚀")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                            .padding()
//                    }
//                    .navigationDestination(isPresented: $showSummary) {
//                            UserSummaryView(name:  name,
//                                            email: email,
//                                            dob:   dateOfBirth
//                            )
//                        }
//                }
//                //.navigationTitle("New User")
//                //.padding()
//            }
//        }
//        .animation(.easeInOut, value: currentStep)
//        .padding()
//    }
//    
//    private func nextStep() {
//        if currentStep < 5 {
//            currentStep += 1
//        }
//    }
//}
//
//






import SwiftUI

struct OnboardUserContentView: View {
    // MARK: ‑ State
    @State private var currentStep = 0
    @State private var name = ""
    @State private var contactNo = ""
    @State private var dob = ""
    @State private var dateOfBirth = Date()
    @State private var email = ""
    @State private var educationLevel = "High School"
    @State private var isJobSeeker = false

    @State private var showSummary = false

    let educationOptions = ["High School", "Diploma",
                            "Bachelor's", "Master's", "PhD"]

    @Environment(\.dismiss) private var dismiss
    var onFinish: () -> Void = {}

    var body: some View {
        NavigationStack {
            VStack {
                //STEP 0
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

                //STEP 1
                } else if currentStep == 1 {
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

                //STEP 2
                } else if currentStep == 2 {
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
                    
                    //STEP 3
                    //                } else if currentStep == 3 {
                    //                    StepView(
                    //                        title: "How can we reach you (Contact No.)? 📧",
                    //                        subtitle: "Your contact number helps us keep you updated.",
                    //                        content: AnyView(
                    //                            TextField("Enter your Contact No.", text: $contactNo)
                    //                                .textFieldStyle(.roundedBorder)
                    //                                .padding()
                    //                        ),
                    //                        actionTitle: "Next",
                    //                        action: { nextStep() }
                    //                    )
                    //
                    //                //STEP 4  ➜  INSERT & PUSH SUMMARY
                    //                }
                } else if currentStep == 3 {
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
                            guard !name.isEmpty, !email.isEmpty else { return }

                            DBManager.shared.insert(
                                name: name,
                                dob: dateOfBirth,
                                email: email
                            )
                            onFinish()
                            showSummary = true    // trigger navigation
                        }
                    )
                } else {
                    // 🎉 Final Welcome Screen
//                    VStack(spacing: 20) {
//                        Image(systemName: "checkmark.circle.fill")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 80, height: 80)
//                            .foregroundColor(.green)
//                        
//                        Text("You're all set, \(name)! 🎉")
//                            .font(.title)
//                            .bold()
//                        
//                        Text("Welcome aboard! Get ready for AI-powered career guidance tailored just for you.")
//                            .multilineTextAlignment(.center)
//                            .padding()
//                        
//                        Button(action: { }) {
//                            Text("Let's Go 🚀")
//                                .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(10)
//                                .padding()
//                        }
//                    }
                }
            }
            .animation(.easeInOut, value: currentStep)
            .padding()
            .navigationDestination(isPresented: $showSummary) {
                UserSummaryView(
                    name: name,
                    email: email,
                    dob: dob,
                    contactNo: contactNo
                )
            }
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
        VStack(spacing: 20) {
            Text(title)
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.top)

            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            content

            Button(action: action) {
                Text(actionTitle)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .padding()
    }
}


