//
//  AllKeychainItemsView.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-06.
//


import SwiftUI

struct AllKeychainItemsView: View {
    @EnvironmentObject private var session: SessionStore         // to log out after wipe
    @State private var items: [(account: String, service: String, password: String)] = []
    @State private var loadError: String?   = nil
    @State private var deleteMessage: String? = nil
    
    var body: some View {
        List {
            if let err = loadError {
                Text("❗️\(err)").foregroundColor(.red)
            } else if items.isEmpty {
                Text("No Keychain items found.").foregroundColor(.secondary)
            } else {
                ForEach(items.indices, id: \.self) { i in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Service: \(items[i].service)")
                        Text("Account: \(items[i].account)")
                        Text("Password: \(items[i].password)")
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
                
                // Destructive footer
                Section {
                    Button("Delete ALL Credentials", role: .destructive) {
                        wipeAll()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            if let msg = deleteMessage {
                Text(msg).foregroundColor(.secondary)
            }
        }
        .navigationTitle("All Keychain Items")
        .onAppear(perform: load)
    }
    
    // MARK: – helpers
    private func load() {
        do { items = try KeychainHelper.readAll() }
        catch { loadError = error.localizedDescription }
    }
    
    private func wipeAll() {
        do {
            try KeychainHelper.deleteAll()
            deleteMessage = "All credentials removed."
            items = []
            session.logout()             // snap UI back to LoginView
        } catch {
            deleteMessage = "Delete failed: \(error.localizedDescription)"
        }
    }
}
