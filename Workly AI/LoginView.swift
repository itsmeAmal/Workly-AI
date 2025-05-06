//
//  LoginView.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-06.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var session: SessionStore
    
    @State private var user  = ""
    @State private var pass  = ""
    @State private var error = ""
    
    var body: some View {
        NavigationStack {
            Form {
                // ── Fields ──────────────────────────────────
                Section("Credentials") {
                    TextField("Username", text: $user)
                        .textInputAutocapitalization(.none)
                    SecureField("Password", text: $pass)
                }
                
                // ── First‑run: show REGISTER only ───────────
                if !session.hasSavedCreds {
                    Section {
                        Button("Register") { register() }
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                
                // ── Credentials exist: show LOG IN only ─────
                else {
                    Section {
                        Button("Log In") { login() }
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                
                // ── Error feedback ──────────────────────────
                if !error.isEmpty {
                    Section { Text(error).foregroundColor(.red) }
                }
            }
            .navigationTitle("Sign In")
            .onAppear(perform: preload)          // autofill if creds exist
        }
    }
    
    // MARK: – Helpers
    /// Autofill username+password when Keychain already has them
    private func preload() {
        if let saved = (try? KeychainHelper.read()) ?? nil {
            user = saved.username
            pass = saved.password
        }
    }

    
    private func login() {
        do {
            try session.login(user: user, pass: pass)
        } catch {
            self.error = error.localizedDescription
        }
    }
    
    private func register() {
        do {
            try session.register(user: user, pass: pass)
        } catch {
            self.error = error.localizedDescription
        }
    }
}
