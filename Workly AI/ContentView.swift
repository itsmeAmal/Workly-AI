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
    
    @State private var isEditing = false
    
    init(user: User) {
        _user = State(initialValue: user)
    }
        
    @State private var users: [User] = DBManager.shared.fetchUsers()
    
    var body: some View {
        NavigationStack {
            ZStack {
                // — Gradient backdrop —
                LinearGradient(
                    colors: [Color(#colorLiteral(red:0.16, green:0.28, blue:0.62, alpha:1)),
                             Color(#colorLiteral(red:0.46, green:0.27, blue:0.75, alpha:1))],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        
                        // Avatar & name
                        VStack(spacing: 12) {
                            Image(systemName: "person.crop.circle.fill")
                                .font(.system(size: 96))
                                .foregroundColor(.white.opacity(0.9))
                                .shadow(radius: 6)
                            
                            Text(user.name)
                                .font(.title2.weight(.semibold))
                                .foregroundColor(.white)
                        }
                        .padding(.top, 16)
                        
                        // Glassy card with details
                        VStack(alignment: .leading, spacing: 18) {
                            // — Personal —
                            Text("Personal Details")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.9))
                            
                            infoRow(label: "birthday.cake.fill", text: user.dob)
                            infoRow(label: "person.circle.fill", text: user.gender)
                            infoRow(label: "briefcase.fill",
                                    text: user.isJobSeeker ? "Actively seeking a job" : "Not seeking a job")
                            
                            Divider().background(.white.opacity(0.25))
                            
                            // — Education & Contact —
                            Text("Education & Contact")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.9))
                            
                            infoRow(label: "graduationcap.fill", text: user.educationLevel)
                            infoRow(label: "phone.fill",          text: user.contactNo)
                            infoRow(label: "envelope.fill",       text: user.email)
                        }
                        .padding(24)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(.thinMaterial)
                        .cornerRadius(24)
                        .shadow(color: .black.opacity(0.25), radius: 10, y: 4)
                        .padding(.horizontal, 24)
                        
                        // Edit button
                        Button("Edit Profile") {
                            isEditing = true
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.bottom, 32)
                    }
                }
            }
            .sheet(isPresented: $isEditing) {
                if let currentUser = users.first {
                    ProfileEditView(user: user)
                } else {
                    Text("No profile yet")
                }
            }
            .navigationTitle("Profile")
        }
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
        NavigationStack {
            ZStack {
                backgroundGradient
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 28) {
                        personalCard()               // <─ extracted
                        educationCard()              // <─ extracted
                        
                        Button("Save Changes", action: save)
                            .buttonStyle(.borderedProminent)
                            .padding(.bottom, 32)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)
                }
            }
            .navigationTitle("Edit Profile")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }

    // Gradient reused by both cards
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [Color(#colorLiteral(red:0.16, green:0.28, blue:0.62, alpha:1)),
                     Color(#colorLiteral(red:0.46, green:0.27, blue:0.75, alpha:1))],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    // ───────── Personal Details card ─────────
    @ViewBuilder
    private func personalCard() -> some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Personal Details")
                .font(.headline)
                .foregroundColor(.white.opacity(0.9))
            
            TextField("Full Name", text: $name)
                .textFieldStyle(.roundedBorder)
            
            DatePicker("Date of Birth",
                       selection: $dateOfBirth,
                       displayedComponents: .date)
                .datePickerStyle(.compact)
                .accentColor(.white)
            
            Picker("Gender", selection: $gender) {
                ForEach(genderOptions, id: \.self) { Text($0) }
            }
            .pickerStyle(.segmented)
        }
        .cardStyle()
    }

    // ───────── Education & Contact card ──────
    @ViewBuilder
    private func educationCard() -> some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Education & Contact")
                .font(.headline)
                .foregroundColor(.white.opacity(0.9))
            
            Picker("Education Level", selection: $educationLevel) {
                ForEach(educationOptions, id: \.self) { Text($0) }
            }
            .pickerStyle(.menu)
            
            TextField("Contact Number", text: $contactNo)
                .textFieldStyle(.roundedBorder)
            
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
        }
        .cardStyle()
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



// --- Glass card modifier used by many screens ---
private struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(24)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.thinMaterial)
            .cornerRadius(24)
            .shadow(radius: 10)
    }
}


private extension View {
    func cardStyle() -> some View { self.modifier(CardStyle()) }
}

//// ───────── Modifier for both cards ───────
//private extension View {
//    func cardStyle() -> some View {
//        self
//            .padding(24)
//            .frame(maxWidth: .infinity, alignment: .leading)
//            .background(.thinMaterial)
//            .cornerRadius(24)
//            .shadow(radius: 10)
//    }
//}




struct SettingsView: View {
    @EnvironmentObject private var session: SessionStore
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient background (consistent with other screens)
                LinearGradient(
                    colors: [Color(#colorLiteral(red:0.16, green:0.28, blue:0.62, alpha:1)),
                             Color(#colorLiteral(red:0.46, green:0.27, blue:0.75, alpha:1))],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 44) {
                        
                        // ── Cards with NavigationLinks ─────────────
                        settingsCard {
                            menuRow(label: "Account",  system: "person.crop.circle") {
                                Text("Account settings coming soon.")
                                    .padding()
                                    .navigationTitle("Account")
                            }
                            .padding(.horizontal, 20)
                            menuRow(label: "About",    system: "info.circle") {
                                VStack(spacing: 16) {
                                    Image(systemName: "info.circle")
                                        .font(.system(size: 48))
                                    Text("Workly.AI v1.0\n© 2025 Your Name")
                                        .multilineTextAlignment(.center)
                                }
                                .padding()
                                .navigationTitle("About")
                            }
                            .padding(.horizontal, 20)
                            menuRow(label: "Credentials", system: "key.fill") {
                                CredentialsView()
                            }
                            .padding(.horizontal, 20)
                            menuRow(label: "All Keychain Items", system: "server.rack") {
                                AllKeychainItemsView()
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        // ── Log Out button ────────────────────────
                        Button("Log Out", role: .destructive) {
                            session.logout()
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.bottom, 42)
                    }
                    .padding(.horizontal, 34)
                    .padding(.top, 24)
                }
            }
            .navigationTitle("Settings")
        }
    }

    // MARK: – Small UI helpers
    @ViewBuilder
    private func menuRow<Destination: View>(
        label: String,
        system: String,
        @ViewBuilder destination: @escaping () -> Destination
    ) -> some View {
        NavigationLink {
            destination()
        } label: {
            HStack(spacing: 16) {
                Image(systemName: system)
                    .font(.system(size: 20))
                    .foregroundColor(.white.opacity(0.9))
                Text(label)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.white.opacity(0.7))
            }
            .padding(.vertical, 12)
        }
    }

    @ViewBuilder
    private func settingsCard<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        VStack(spacing: 0, content: content)
            .padding(.vertical, 4)
            .frame(maxWidth: .infinity)
            .background(.thinMaterial)
            .cornerRadius(24)
            .shadow(radius: 10, y: 4)
    }

}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


