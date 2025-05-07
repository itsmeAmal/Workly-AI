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
    
//    var body: some View {
//        Form {
//            // ── Existing item ────────────────────────────────
//            if let c = creds {
//                Section("Saved in Keychain") {
//                    HStack {
//                        Text("Username")
//                        Spacer()
//                        Text(c.username).foregroundColor(.primary)
//                    }
//                    HStack {
//                        Text("Password")
//                        Spacer()
//                        Text(c.password).foregroundColor(.primary)
//                    }
//                    
//                    // Delete button
//                    Button("Delete Credentials", role: .destructive) {
//                        deleteCreds()
//                    }
//                    .frame(maxWidth: .infinity, alignment: .center)
//                }
//            }
//            
//            // ── Empty / error states ─────────────────────────
//            else if let err = readError {
//                Text("❗️ \(err)").foregroundColor(.red)
//            } else {
//                Text("No credentials found in Keychain.")
//                    .foregroundColor(.secondary)
//            }
//            
//            // optional feedback after deletion
//            if let msg = deleteMessage {
//                Text(msg).foregroundColor(.secondary)
//            }
//        }
//        .navigationTitle("Keychain Data")
//        .onAppear(perform: loadCreds)
//    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient backdrop (same palette as other screens)
                LinearGradient(
                    colors: [Color(#colorLiteral(red:0.16, green:0.28, blue:0.62, alpha:1)),
                             Color(#colorLiteral(red:0.46, green:0.27, blue:0.75, alpha:1))],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 24) {
                    // ── Success state ───────────────────────────
                    if let c = creds {
                        VStack(spacing: 20) {
                            Image(systemName: "key.fill")
                                .font(.system(size: 48))
                                .foregroundColor(.white)
                                .shadow(radius: 6)
                            
                            VStack(spacing: 12) {
                                credentialRow(label: "Username", value: c.username)
                                credentialRow(label: "Password", value: c.password)
                            }
                            
                            Button("Delete Credentials", role: .destructive) {
                                deleteCreds()
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.top, 8)
                        }
                        .padding(32)
                        .frame(maxWidth: .infinity)
                        .background(.thinMaterial)
                        .cornerRadius(24)
                        .shadow(radius: 10)
                    }
                    
                    // ── Error state ────────────────────────────
                    else if let err = readError {
                        errorLabel("❗️ \(err)")
                    }
                    
                    // ── Empty state ────────────────────────────
                    else {
                        errorLabel("No credentials found in Keychain.")
                    }
                    
                    // ── Feedback after delete ──────────────────
                    if let msg = deleteMessage {
                        Text(msg)
                            .font(.footnote)
                            .foregroundColor(.white.opacity(0.9))
                    }
                }
                .padding(.horizontal, 32)
            }
            .navigationTitle("Keychain Data")
            .onAppear(perform: loadCreds)
        }
    }

    // MARK: – Small UI helpers
    @ViewBuilder
    private func credentialRow(label: String, value: String) -> some View {
        HStack {
            Text(label)
            Spacer()
            Text(value)
                .foregroundColor(.white)
                .textSelection(.enabled)
        }
        .font(.callout.weight(.semibold))
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.15))
        .cornerRadius(12)
    }

    @ViewBuilder
    private func errorLabel(_ text: String) -> some View {
        Text(text)
            .multilineTextAlignment(.center)
            .foregroundColor(.white.opacity(0.9))
            .padding()
            .background(.thinMaterial)
            .cornerRadius(20)
            .shadow(radius: 8)
            .padding(.horizontal, 32)
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


