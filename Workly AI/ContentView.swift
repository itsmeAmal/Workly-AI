//
//  ContentView.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-03-29.
//


import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
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


struct ProfileView: View {
    @State private var user: User

    init(user: User) {
        _user = State(initialValue: user)
    }

    var body: some View {
        Form {
            Section(header: Text("Personal Details")) {
                infoRow(label: "person.fill", text: user.name)
                infoRow(label: "birthday.cake.fill", text: user.dob)
            }

            Section(header: Text("Contact")) {
                infoRow(label: "phone.fill", text: user.contactNo)
                infoRow(label: "envelope.fill", text: user.email)
            }
        }
        .navigationTitle("Profile")
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




//struct ProfileView: View {
//    @State private var users: [User] = DBManager.shared.fetchUsers()
//    @State private var showingAdd = false
//    
//    @State private var isEditing = false
//    
//    //@State private var name: String = "John Doe"
//    @State private var dateOfBirth: Date = Date()
//    //@State private var gender: String = "Male"
//    //@State private var educationLevel: String = "Bachelor's Degree"
//    //@State private var contactNo: String = "+1 234 567 890"
//    //@State private var email: String = "johndoe@example.com"
//    @State private var password: String = "password123"
//
//    let name: String
//    let email: String
//    let dob: String
//    let gender: String
//    let educationLevel: String
//    let contactNo: String
//
//    let genderOptions = ["Male", "Female", "Other"]
//    let educationOptions = ["High School", "Diploma", "Bachelor's Degree", "Master's Degree", "PhD"]
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Personal Details")) {
//                    
//                    HStack(spacing: 8) {
//                        Image(systemName: "person.fill")
//                            .foregroundColor(.secondary)
//
//                        //Text(users.name)
//                        TextField("Full Name", text: .constant(name))
//                            .disabled(true)   //keep it read‑only
//                    }
//                    //TextField("Full Name", text: .constant(name))
//                    
//                    HStack(spacing: 8) {
//                        Image(systemName: "cake.fill")
//                            .foregroundColor(.secondary)
//
//                        TextField("Date of Birth", text: .constant(dob))
//                            .disabled(true)   //keep it read‑only
//                    }
//                    //DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
//                    
//                    HStack(spacing: 8) {
//                        Image(systemName: "gender.fill")
//                            .foregroundColor(.secondary)
//
//                        TextField("Gender", text: .constant(gender))
//                            .disabled(true)   //keep it read‑only
//                    }
////                    Picker("Gender", selection: $gender) {
////                        ForEach(genderOptions, id: \.self) { option in
////                            Text(option)
////                        }
////                    }
//                    
//                }
//                
//                
//                
//                Section(header: Text("Education & Contact")) {
//                    HStack(spacing: 8) {
//                        Image(systemName: "education.fill")
//                            .foregroundColor(.secondary)
//                        
//                        TextField("Higher Education Level", text: .constant(educationLevel))
//                            .disabled(true)   //keep it read‑only
//                    }
//                    //                    Picker("Higher Education Level", selection: $educationLevel) {
//                    //                        ForEach(educationOptions, id: \.self) { option in
//                    //                            Text(option)
//                    //                        }
//                    //                    }
//                    
//                    HStack(spacing: 8) {
//                        Image(systemName: "phone.fill")
//                            .foregroundColor(.secondary)
//                        
//                        TextField("Contact Number", text: .constant(contactNo))
//                            .disabled(true)   //keep it read‑only
//                    }
//                    //                    TextField("Contact Number", text: $contactNo)
//                    //                        .keyboardType(.phonePad)
//                    
//                    
//                    HStack(spacing: 8) {
//                        Image(systemName: "envelop.fill")
//                            .foregroundColor(.secondary)
//                        
//                        TextField("Email", text: .constant(email))
//                            .disabled(true)  //keep it read‑only
//                    }
//                    //TextField("Email", text: .constant(email)).keyboardType(.emailAddress)
//                    
//                }
//                
//                
//                Section(header: Text("Security")) {
//                    SecureField("Password", text: $password)
//                }
//                
//                
////                Section {
////                    Button(action: updateProfile) {
////                        Text("Update Profile")
////                            .frame(maxWidth: .infinity, alignment: .center)
////                    }
////                    .buttonStyle(.borderedProminent)
////                }
//                Button(action: {
//                    isEditing = true
//                }) {
//                    Text("Edit Profile")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                        .padding()
//                }
//                .sheet(isPresented: $isEditing) {
//                    ProfileEditView()
//                }
//            }
//            .navigationTitle("Profile")
//        }
//    }
//
//    func updateProfile() {
//        print("Profile Updated")
//    }
//
//}
//




struct ProfileEditView: View {
    @State private var name: String = "John Doe"
    @State private var dateOfBirth: Date = Date()
    @State private var gender: String = "Male"
    @State private var educationLevel: String = "Bachelor's Degree"
    @State private var contactNo: String = "+1 234 567 890"
    @State private var email: String = "johndoe@example.com"
    
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
                    Button("Save Changes") {
                       
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarItems(trailing: Button("Done") {
            })
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
