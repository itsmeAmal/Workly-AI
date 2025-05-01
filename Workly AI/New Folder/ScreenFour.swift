//
//  ScreenFour.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-01.
//



import SwiftUI

struct ScreenFour: View {
    @Environment(\.presentationMode) private var presentationMode

    // Editable state properties
    @State private var fullName: String = "John Doe"
    @State private var dateOfBirth: String = "January 1, 1990"
    @State private var gender: String = "Male"
    @State private var educationLevel: String = "Bachelor’s Degree"
    @State private var contactNumber: String = "+94711023694"
    @State private var email: String = "johndoe@gmail.com"

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // PERSONAL DETAILS TITLE
                    Text("PERSONAL DETAILS")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(navColor)
                        .padding(.horizontal, 24)

                    // Personal Details Card
                    VStack(spacing: 0) {
                        EditableInfoRow(label: "Full Name", text: $fullName)
                            .padding(16)
                        Divider().background(Color.gray.opacity(0.3))
                        EditableInfoRow(label: "Date of Birth", text: $dateOfBirth)
                            .padding(16)
                        Divider().background(Color.gray.opacity(0.3))
                        EditableInfoRow(label: "Gender", text: $gender)
                            .padding(16)
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal, 24)

                    
                    Spacer().frame(height: 5)

                    
                    // EDUCATION & CONTACT TITLE
                    Text("EDUCATION & CONTACT")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(navColor)
                        .padding(.horizontal, 24)

                    // Education & Contact Card
                    VStack(spacing: 0) {
                        EditableInfoRow(label: "Higher Education level", text: $educationLevel)
                            .padding(16)
                        Divider().background(Color.gray.opacity(0.3))
                        EditableInfoRow(label: "Contact Number", text: $contactNumber)
                            .padding(16)
                        Divider().background(Color.gray.opacity(0.3))
                        EditableInfoRow(label: "Email", text: $email, isEmail: true)
                            .padding(16)
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal, 24)

                    // SAVE CHANGES BUTTON
                    Button(action: {
                        // Handle save action
                    }) {
                        Text("Save Changes")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 8)

                    Spacer(minLength: 30)
                }
                .padding(.vertical, 24)
                .background(sheetColor)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Edit Profile")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .font(.subheadline)
                    .foregroundColor(.blue)
                }
            }
            .background(navColor)
        }
    }

    // MARK: - Colors
    private var navColor: Color { Color(red: 0.11, green: 0.17, blue: 0.29) }
    private var sheetColor: Color { Color(red: 0.95, green: 0.95, blue: 0.93) }
}

// MARK: - EditableInfoRow
struct EditableInfoRow: View {
    let label: String
    @Binding var text: String
    var isEmail: Bool = false

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(Color(red: 0.11, green: 0.17, blue: 0.29))
            Spacer()
            if isEmail {
                TextField("", text: $text)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.trailing)
            } else {
                TextField("", text: $text)
                    .font(.subheadline)
                    .foregroundColor(Color(red: 0.11, green: 0.17, blue: 0.29))
                    .multilineTextAlignment(.trailing)
            }
        }
    }
}

struct ScreenFour_Previews: PreviewProvider {
    static var previews: some View {
        ScreenFour()
    }
}
