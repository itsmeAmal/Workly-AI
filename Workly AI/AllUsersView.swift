//
//  AllUsersView.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-03.
//


import SwiftUI

// Swipe to removes the row on disk and from the list
struct AllUsersView: View {
    @State private var users: [User] = []

    var body: some View {
        ZStack {
            // Gradient backdrop (same palette as other screens)
            LinearGradient(
                colors: [Color(#colorLiteral(red:0.16, green:0.28, blue:0.62, alpha:1)),
                         Color(#colorLiteral(red:0.46, green:0.27, blue:0.75, alpha:1))],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            List {
                ForEach(users) { user in
                    userRow(user)
                        .listRowBackground(Color.clear)   // transparent row bg
                        .listRowSeparator(.hidden)        // hide default line
                }
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
            .navigationTitle("All Users (\(users.count))")
            .toolbar { EditButton() }
            .onAppear(perform: load)
            .refreshable { load() }
        }
    }


    //Row & helpers
    @ViewBuilder private func userRow(_ user: User) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(user.name)
                .font(.headline)
                .foregroundColor(.white)
            
            Label(user.email, systemImage: "envelope.fill")
            Label(user.dob,   systemImage: "birthday.cake.fill")
            Label(user.educationLevel, systemImage: "graduationcap.fill")
            Label(user.contactNo,      systemImage: "phone.fill")
        }
        .font(.footnote)
        .foregroundColor(.white.opacity(0.9))
        .cardStyle()                     // glassy card modifier
        .padding(.vertical, 4)
    }

    
    private func load() {
        users = DBManager.shared.fetchUsers()
    }
    
    
    private func delete(at offsets: IndexSet) {
        offsets.map { users[$0].id }.forEach(DBManager.shared.delete)
        users.remove(atOffsets: offsets)
    }
}




private struct CardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.thinMaterial)
            .cornerRadius(20)
            .shadow(color: .black.opacity(0.25), radius: 6, y: 4)
    }
}
private extension View {
    func cardStyle() -> some View { self.modifier(CardStyle()) }
}
