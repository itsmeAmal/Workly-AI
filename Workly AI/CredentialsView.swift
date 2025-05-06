//
//  CredentialsView.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-06.
//


import SwiftUI

struct CredentialsView: View {
    @EnvironmentObject private var session: SessionStore   // so we can auto‑log‑out
    @State private var creds: (username: String, password: String)? = nil
    @State private var readError: String? = nil
    @State private var deleteMessage: String? = nil        // feedback after delete
    
    var body: some View {
        Form {
            // ── Existing item ────────────────────────────────
            if let c = creds {
                Section("Saved in Keychain") {
                    HStack {
                        Text("Username")
                        Spacer()
                        Text(c.username).foregroundColor(.primary)
                    }
                    HStack {
                        Text("Password")
                        Spacer()
                        Text(c.password).foregroundColor(.primary)
                    }
                    
                    // Delete button
                    Button("Delete Credentials", role: .destructive) {
                        deleteCreds()
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            
            // ── Empty / error states ─────────────────────────
            else if let err = readError {
                Text("❗️ \(err)").foregroundColor(.red)
            } else {
                Text("No credentials found in Keychain.")
                    .foregroundColor(.secondary)
            }
            
            // optional feedback after deletion
            if let msg = deleteMessage {
                Text(msg).foregroundColor(.secondary)
            }
        }
        .navigationTitle("Keychain Data")
        .onAppear(perform: loadCreds)
    }
    
    // MARK: – helpers
    private func loadCreds() {
        do {
            creds = try KeychainHelper.read()
            if let c = creds {
                print("DEBUG – read:", c.username, c.password)
            } else {
                print("DEBUG – Keychain empty")
            }
        } catch {
            readError = error.localizedDescription
            print("DEBUG – read error:", error.localizedDescription)
        }
    }
    
    private func deleteCreds() {
        do {
            try session.deleteCredentials()   // wipes item + ends session
            deleteMessage = "Credentials removed."
            creds = nil
            // also log the session out so the UI returns to LoginView
            session.logout()
            print("DEBUG – credentials deleted")
        } catch {
            deleteMessage = "Delete failed: \(error.localizedDescription)"
            print("DEBUG – delete error:", error.localizedDescription)
        }
    }

    
//    private func deleteCreds() {
//        do {
//            try KeychainHelper.delete()
//            deleteMessage = "Credentials removed."
//            creds = nil
//            // also log the session out so the UI returns to LoginView
//            session.logout()
//            print("DEBUG – credentials deleted")
//        } catch {
//            deleteMessage = "Delete failed: \(error.localizedDescription)"
//            print("DEBUG – delete error:", error.localizedDescription)
//        }
//    }
    
    
}


