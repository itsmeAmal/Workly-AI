//
//  ContentView.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-03-29.
//


import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    @State private var reloadKey = UUID()
    @State private var users: [User] = DBManager.shared.fetchUsers()
        
    var body: some View {
        TabView(selection: $selectedTab) {
            DashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
                .tag(0)
            
            BotGuideView()
                .tabItem {
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                    Text("Bot Guide")
                }
                .tag(1)
            
            ChatBotContentView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Chatbot")
                }
                .tag(2)
            
            MockInterviewView()
                .tabItem {
                    Image(systemName: "person.text.rectangle.fill")
                    Text("Mock Interview")
                }
                .tag(3)

            
            
            if let currentUser = users.first {
                            ProfileView(user: currentUser)
                                .tabItem {
                                    Image(systemName: "person.crop.circle.fill")
                                    Text("Profile")
                                }
                                .tag(4)
                        } else {
                            // Placeholder tab until the user finishes onboarding
                            Text("No profile yet")
                                .tabItem {
                                    Image(systemName: "person.crop.circle")
                                    Text("Profile")
                                }
                                .tag(4)
                        }
            
            
//            if let newest = DBManager.shared.fetchUsers().first {
//                ProfileView(userID: newest.id)
//                    .tabItem {
//                        Image(systemName: "person.crop.circle.fill")
//                        Text("Profile")
//                    }
//                    .tag(4)
//            }

                                    
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(5)
            
            
            OnboardUserContentView(onFinish: {})
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Onboard User")
                }
                .tag(6)
            
            
            AllUsersView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Users")
                }
                .tag(7)

        }
    }
}


struct DashboardView: View {
    var body: some View {
        DashboardContentView()
    }
}


struct BotGuideView: View {
    var body: some View {
        Text("AI-Powered Chatbot for Career Guidance")
            .font(.title)
            .padding()
    }
}


struct MockInterviewView: View {
    var body: some View {
        Text("Personalized Interview Preparation")
            .font(.title)
            .padding()
    }
}




//struct ProfileView: View {
//    // Pass only the record’s id so the view can always fetch fresh data
//    let userID: Int32
//
//    // Snapshot of the row we’re showing
//    @State private var user: User?
//
//    // Controls the edit sheet
//    @State private var isEditing = false
//
//    var body: some View {
//        Form {
//            if let u = user {                              // show once loaded
//                personalSection(u)
//                educationSection(u)
//
//                Button("Edit Profile") { isEditing = true }
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .padding(.vertical)
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//                    .sheet(isPresented: $isEditing) {
//                        ProfileEditView(user: u)           // pass snapshot
//                    }
//            } else {
//                ProgressView()
//                    .frame(maxWidth: .infinity, alignment: .center)
//            }
//        }
//        .navigationTitle("Profile")
//        .onAppear(perform: load)                           // reload each visit
//        .onReceive(NotificationCenter.default
//                   .publisher(for: .userDataChanged)) { _ in load() } // live refresh
//    }
//
//    // MARK: – Sub‑views
//    @ViewBuilder
//    private func personalSection(_ u: User) -> some View {
//        Section(header: Text("Personal Details")) {
//            infoRow(label: "person.fill", text: u.name)
//            infoRow(label: "birthday.cake.fill", text: u.dob)
//            infoRow(label: "person.circle.fill", text: u.gender)
//            infoRow(label: "briefcase.fill",
//                    text: u.isJobSeeker ? "Actively seeking a job"
//                                         : "Not seeking a job")
//        }
//    }
//
//    @ViewBuilder
//    private func educationSection(_ u: User) -> some View {
//        Section(header: Text("Education & Contact")) {
//            infoRow(label: "graduationcap.fill", text: u.educationLevel)
//            infoRow(label: "phone.fill", text: u.contactNo)
//            infoRow(label: "envelope.fill", text: u.email)
//        }
//    }
//
//    @ViewBuilder
//    private func infoRow(label systemImage: String, text: String) -> some View {
//        HStack(spacing: 8) {
//            Image(systemName: systemImage)
//                .foregroundColor(.secondary)
//            Text(text)
//        }
//    }
//
//    // MARK: – Data loader
//    private func load() {
//        user = DBManager.shared
//                .fetchUsers()
//                .first { $0.id == userID }    // latest snapshot
//    }
//}




struct ProfileView: View {
    @State private var user: User
    
    @State private var isEditing = false
    
    init(user: User) {
        _user = State(initialValue: user)
    }
        
    @State private var users: [User] = DBManager.shared.fetchUsers()
    
    var body: some View {
        Form {
            Section(header: Text("Personal Details")) {
                infoRow(label: "person.fill", text: user.name)
                infoRow(label: "birthday.cake.fill", text: user.dob)
                infoRow(label: "person.circle.fill", text: user.gender)
                infoRow(label: "briefcase.fill", text: user.isJobSeeker ? "Actively seeking for a Job" : "Not seeking for a Job")
            }
            
            Section(header: Text("Education & Contact")) {
                infoRow(label: "graduationcap.fill", text: user.educationLevel)
                infoRow(label: "phone.fill", text: user.contactNo)
                infoRow(label: "envelope.fill", text: user.email)
            }
            
            //.padding(.vertical)
            
            Button(action: {
                isEditing = true
            }) {
                Text("Edit Profile")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                
            }
            .sheet(isPresented: $isEditing) {
                if let currentUser = users.first {
                    ProfileEditView(user: user)
                        .tabItem {
                            Image(systemName: "person.crop.circle.fill")
                            Text("Profile")
                        }
                        .tag(4)
                } else {
                    // Placeholder tab until the user finishes onboarding
                    Text("No profile yet")
                        .tabItem {
                            Image(systemName: "person.crop.circle")
                            Text("Profile")
                        }
                        .tag(4)
                }
            }
        }
        
        //        Section(header: Text("Security")) {
        //            //SecureField("Password", text: $password)
        //            SecureField("Password", text: "$password")
        //        }
        
        
        .navigationTitle("Profile")
    }
    
    func updateProfile() {
        print("Profile Updated")
    }
    
    // this will avoid repeating the HStack
    @ViewBuilder
    private func infoRow(label systemImage: String, text: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
                .foregroundColor(.secondary)
            Text(text)
        }
    }
}




struct ProfileEditView: View {
    @State private var user: User
    
    @State private var isEditing = true
    
    @State private var name: String
    @State private var dateOfBirth: Date
    @State private var dob: String
    @State private var gender: String
    @State private var educationLevel: String
    @State private var contactNo: String
    @State private var email: String
    
    @Environment(\.dismiss) private var dismiss
    
    init(user: User) {
            _user            = State(initialValue: user)
            _name            = State(initialValue: user.name)
            _dob             = State(initialValue: user.dob)
            // iso → Date
            let iso = ISO8601DateFormatter()
            _dateOfBirth     = State(initialValue: iso.date(from: user.dob) ?? Date())
            _gender          = State(initialValue: user.gender)
            _educationLevel  = State(initialValue: user.educationLevel)
            _contactNo       = State(initialValue: user.contactNo)
            _email           = State(initialValue: user.email)
        }
    
    let genderOptions = ["Male", "Female", "Other"]
    let educationOptions = ["High School", "Diploma", "Bachelor's Degree", "Master's Degree", "PhD"]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Details")) {
                    TextField("Full Name", text: $name)
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    Picker("Gender", selection: $gender) {
                        ForEach(genderOptions, id: \ .self) { Text($0) }
                    }
                }
                
                Section(header: Text("Education & Contact")) {
                    Picker("Higher Education Level", selection: $educationLevel) {
                        ForEach(educationOptions, id: \ .self) { Text($0) }
                    }
                    TextField("Contact Number", text: $contactNo)
                    TextField("Email", text: $email)
                }
                
                Section {
                    Button("Save Changes", action: save)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") { dismiss() }
                            }
                        }
            .navigationBarItems(trailing: Button("Done") {
            })
        }
    }
    
    private func save() {
            let iso = ISO8601DateFormatter()
            user.name       = name
            user.dob        = iso.string(from: dateOfBirth)
            user.gender     = gender
            user.educationLevel  = educationLevel
            user.contactNo  = contactNo
            user.email      = email

            DBManager.shared.update(user: user)
            dismiss()
        }
    
    // this will avoid repeating the HStack
    @ViewBuilder
    private func infoRow(label systemImage: String, text: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
                .foregroundColor(.secondary)
            Text(text)
        }
    }

}


struct SettingsView: View {
    var body: some View {
        Text("Settings")
            .font(.title)
            .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


