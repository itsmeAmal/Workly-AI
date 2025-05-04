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
        List {
            ForEach(users) { user in
                userRow(user)
            }
            .onDelete(perform: delete)
        }
        .listStyle(.insetGrouped)
        .navigationTitle("All Users (\(users.count))")   //  count
        .toolbar { EditButton() }
        .onAppear(perform: load)
        .refreshable { load() }
    }

    // MARK: – Row & helpers
    @ViewBuilder private func userRow(_ user: User) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(user.name).font(.headline)

            HStack {
                Label(user.email, systemImage: "envelope.fill")
                Spacer(minLength: 12)
                Label(user.dob, systemImage: "birthday.cake.fill")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
            .padding(.vertical, 7)
            
            HStack {
                Label(user.educationLevel, systemImage: "graduationcap.fill")
                Spacer(minLength: 12)
                Label(user.contactNo, systemImage: "phone.fill")
            }
            .font(.subheadline)
            .foregroundColor(.secondary)
                
        }
        .padding(.vertical, 4)
    }

    private func load()              { users = DBManager.shared.fetchUsers() }
    private func delete(at offsets: IndexSet) {
        offsets.map { users[$0].id }.forEach(DBManager.shared.delete)
        users.remove(atOffsets: offsets)
    }
}
