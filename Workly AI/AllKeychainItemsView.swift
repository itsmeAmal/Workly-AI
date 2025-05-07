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
    
//    var body: some View {
//        List {
//            if let err = loadError {
//                Text("❗️\(err)").foregroundColor(.red)
//            } else if items.isEmpty {
//                Text("No Keychain items found.").foregroundColor(.secondary)
//            } else {
//                ForEach(items.indices, id: \.self) { i in
//                    VStack(alignment: .leading, spacing: 4) {
//                        Text("Service: \(items[i].service)")
//                        Text("Account: \(items[i].account)")
//                        Text("Password: \(items[i].password)")
//                            .foregroundColor(.secondary)
//                    }
//                    .padding(.vertical, 4)
//                }
//                
//                // Destructive footer
//                Section {
//                    Button("Delete ALL Credentials", role: .destructive) {
//                        wipeAll()
//                    }
//                    .frame(maxWidth: .infinity, alignment: .center)
//                }
//            }
//            
//            if let msg = deleteMessage {
//                Text(msg).foregroundColor(.secondary)
//            }
//        }
//        .navigationTitle("All Keychain Items")
//        .onAppear(perform: load)
//    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient backdrop (keeps visual consistency)
                LinearGradient(
                    colors: [Color(#colorLiteral(red:0.16, green:0.28, blue:0.62, alpha:1)),
                             Color(#colorLiteral(red:0.46, green:0.27, blue:0.75, alpha:1))],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        // ── Error state ───────────────────────────
                        if let err = loadError {
                            errorLabel("❗️\(err)")
                        }
                        
                        // ── Empty state ───────────────────────────
                        else if items.isEmpty {
                            errorLabel("No Keychain items found.")
                        }
                        
                        // ── Success state (cards for each item) ──
                        else {
                            ForEach(items.indices, id: \.self) { i in
                                itemCard(items[i])
                            }
                            
                            Button("Delete ALL Credentials", role: .destructive) {
                                wipeAll()
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.top, 12)
                        }
                        
                        // Optional feedback after wipe
                        if let msg = deleteMessage {
                            Text(msg)
                                .font(.footnote)
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.top, 4)
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 32)
                }
            }
            .navigationTitle("All Keychain Items")
            .onAppear(perform: load)
        }
    }

    // MARK: – Small UI helpers
    @ViewBuilder
    private func itemCard(_ item: (account: String, service: String, password: String)) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "server.rack")
                Text(item.service)
            }
            .font(.headline)
            .foregroundColor(.white)
            
            Text("Account: \(item.account)")
                .foregroundColor(.white.opacity(0.9))
            
            Text("Password: \(item.password)")
                .foregroundColor(.white.opacity(0.8))
                .textSelection(.enabled)
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.thinMaterial)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.25), radius: 8, y: 4)
    }

    @ViewBuilder
    private func errorLabel(_ text: String) -> some View {
        Text(text)
            .multilineTextAlignment(.center)
            .foregroundColor(.white.opacity(0.95))
            .padding()
            .frame(maxWidth: .infinity)
            .background(.thinMaterial)
            .cornerRadius(20)
            .shadow(radius: 8)
            .padding(.horizontal, 12)
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
