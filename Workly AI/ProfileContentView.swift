//
//  ProfileContentView.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-03-29.
//

//import SwiftUI
//
//struct ProfileContentView: View {
//    @State private var name: String = "John Doe"
//    @State private var dateOfBirth: Date = Date()
//    @State private var gender: String = "Male"
//    @State private var educationLevel: String = "Bachelor's Degree"
//    @State private var contactNo: String = "+1 234 567 890"
//    @State private var email: String = "johndoe@example.com"
//    @State private var password: String = "password123"
//    
//    let genderOptions = ["Male", "Female", "Other"]
//    let educationOptions = ["High School", "Diploma", "Bachelor's Degree", "Master's Degree", "PhD"]
//
//    var body: some View {
//        NavigationView {
//            Form {
//                Section(header: Text("Personal Details")) {
//                    TextField("Full Name", text: $name)
//                    
//                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
//                    
//                    Picker("Gender", selection: $gender) {
//                        ForEach(genderOptions, id: \.self) { option in
//                            Text(option)
//                        }
//                    }
//                }
//                
//                Section(header: Text("Education & Contact")) {
//                    Picker("Higher Education Level", selection: $educationLevel) {
//                        ForEach(educationOptions, id: \.self) { option in
//                            Text(option)
//                        }
//                    }
//                    
//                    TextField("Contact Number", text: $contactNo)
//                        .keyboardType(.phonePad)
//                    
//                    TextField("Email", text: $email)
//                        .keyboardType(.emailAddress)
//                }
//                
//                Section(header: Text("Security")) {
//                    SecureField("Password", text: $password)
//                }
//                
//                Section {
//                    Button(action: updateProfile) {
//                        Text("Update Profile")
//                            .frame(maxWidth: .infinity, alignment: .center)
//                    }
//                    .buttonStyle(.borderedProminent)
//                }
//            }
//            .navigationTitle("Profile")
//        }
//    }
//
//    func updateProfile() {
//        print("Profile Updated")
//    }
//}
//
//
//
//struct ProfileContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileContentView()
//    }
//}







import SwiftUI

struct ProfileContentView: View {
    //@State private var name: String = "John Doe"
    @State private var dateOfBirth: Date = Date()
    @State private var gender: String = "Male"
    @State private var educationLevel: String = "Bachelor's Degree"
    @State private var contactNo: String = "+1 234 567 890"
    //@State private var email: String = "johndoe@example.com"
    @State private var password: String = "password123"
    
    let name: String
    let email: String
    //let dob: Date
    
    let genderOptions = ["Male", "Female", "Other"]
    let educationOptions = ["High School", "Diploma", "Bachelor's Degree", "Master's Degree", "PhD"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Details")) {
                    HStack(spacing: 8) {
                        Image(systemName: "person.fill")
                            .foregroundColor(.secondary)

                        TextField("Full Name", text: .constant(name))
                            .disabled(true)                       // keeps it read‑only
                    }
                    //TextField("Full Name", text: .constant(name))
                    
                    DatePicker("Date of Birth", selection: $dateOfBirth, displayedComponents: .date)
                    
                    Picker("Gender", selection: $gender) {
                        ForEach(genderOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                }
                
                Section(header: Text("Education & Contact")) {
                    Picker("Higher Education Level", selection: $educationLevel) {
                        ForEach(educationOptions, id: \.self) { option in
                            Text(option)
                        }
                    }
                    
                    TextField("Contact Number", text: $contactNo)
                        .keyboardType(.phonePad)
                    
//                    TextField("Email", text: .constant(email))
//                        .keyboardType(.emailAddress)
                    HStack(spacing: 8) {
                        Image(systemName: "email.fill")
                            .foregroundColor(.secondary)

                        TextField("Email", text: .constant(email))
                            .disabled(true)                       // keeps it read‑only
                    }
                }
                
                Section(header: Text("Security")) {
                    SecureField("Password", text: $password)
                }
                
                Section {
                    Button(action: updateProfile) {
                        Text("Update Profile")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .navigationTitle("Profile")
        }
    }

    func updateProfile() {
        print("Profile Updated")
    }
}



struct ProfileContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContentView(name: "devindiii jayawardena", email: "dev@gmailllll.com")
    }
}





