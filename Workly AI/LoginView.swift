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
    
//    var body: some View {
//        NavigationStack {
//            Form {
//                // ── Fields ──────────────────────────────────
//                Section("Credentials") {
//                    TextField("Username", text: $user)
//                        .textInputAutocapitalization(.none)
//                    SecureField("Password", text: $pass)
//                }
//                
//                // ── First‑run: show REGISTER only ───────────
//                if !session.hasSavedCreds {
//                    Section {
//                        Button("Register") { register() }
//                            .frame(maxWidth: .infinity, alignment: .center)
//                    }
//                }
//                
//                // ── Credentials exist: show LOG IN only ─────
//                else {
//                    Section {
//                        Button("Log In") { login() }
//                            .frame(maxWidth: .infinity, alignment: .center)
//                    }
//                }
//                
//                // ── Error feedback ──────────────────────────
//                if !error.isEmpty {
//                    Section { Text(error).foregroundColor(.red) }
//                }
//            }
//            .navigationTitle("Sign In")
//            .onAppear(perform: preload)          // autofill if creds exist
//        }
//    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color.blue.opacity(0.6), Color.purple.opacity(0.6)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Centered card
                VStack(spacing: 24) {
                    
                    // App icon / headline
                    Image(systemName: "lock.shield")
                        .font(.system(size: 60))
                        .foregroundColor(.white)
                        .padding(.bottom, 8)
                    
                    Text("Welcome to Workly.AI")
                        .font(.largeTitle).bold()
                        .foregroundColor(.white.opacity(0.9))
                    
                    // Card surface
                    VStack(spacing: 20) {
                        
                        // ── Fields ───────────────────────────────
                        VStack(spacing: 16) {
                            TextField("Username", text: $user)
                                .autocapitalization(.none)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                            
                            SecureField("Password", text: $pass)
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(12)
                        }
                        
                        // ── Action button(s) ────────────────────
                        if !session.hasSavedCreds {
                            Button("Register", action: register)
                                .buttonStyle(.borderedProminent)
                                .frame(maxWidth: .infinity)
                        } else {
                            Button("Log In", action: login)
                                .buttonStyle(.borderedProminent)
                                .frame(maxWidth: .infinity)
                        }
                        
                        // ── Error feedback ─────────────────────
                        if !error.isEmpty {
                            Text(error)
                                .foregroundColor(.red)
                                .font(.footnote)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(24)
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .shadow(radius: 15)
                }
                .padding(.horizontal, 32)
            }
            //.navigationTitle("Sign In")
            .onAppear(perform: preload)
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
