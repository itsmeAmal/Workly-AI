//
//  ContentView.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-03-29.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}
import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
//            DashboardView()
//                .tabItem {
//                    Image(systemName: "house.fill")
//                    Text("Dashboard")
//                }
//                .tag(0)
            
//            BotGuideView()
//                .tabItem {
//                    Image(systemName: "bubble.left.and.bubble.right.fill")
//                    Text("Bot Guide")
//                }
//                .tag(1)
//            
            ChatBotContentView()
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Chatbot")
                }
                .tag(2)
            
//            MockInterviewView()
//                .tabItem {
//                    Image(systemName: "person.text.rectangle.fill")
//                    Text("Mock Interview")
//                }
//                .tag(3)
            
            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
                .tag(4)
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Settings")
                }
                .tag(5)
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
        MockInterviewContentView()
    }
}

struct ProfileView: View {
    @State private var isEditing = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Profile")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Form {
                    Section(header: Text("Personal Details")) {
                        Text("Full Name: John Doe")
                        Text("Date of Birth: January 1, 1990")
                        Text("Gender: Male")
                    }
                    
                    Section(header: Text("Education & Contact")) {
                        Text("Higher Education Level: Bachelor's Degree")
                        Text("Contact Number: +1 234 567 890")
                        Text("Email: johndoe@example.com")
                    }
                }
                
                Button(action: {
                    isEditing = true
                }) {
                    Text("Edit Profile")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
                .sheet(isPresented: $isEditing) {
                    ProfileEditView()
                }
            }
        }
    }
}

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
