//
//  SessionStore.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-06.
//

import SwiftUI

@MainActor
final class SessionStore: ObservableObject {
    @Published var loggedInUser: String? = nil
    
    /// true ⇢ there’s already a credential pair in Keychain
    var hasSavedCreds: Bool { (try? KeychainHelper.read()) != nil }
    
    // Auto‑login on launch
    init() {
        if let creds = try? KeychainHelper.read() {
            loggedInUser = creds.username
        }
    }
    
    // --- Auth actions ---
    func login(user: String, pass: String) throws {
        guard let saved = try KeychainHelper.read() else {
            throw AuthError.noSavedCreds
        }
        guard saved.username == user, saved.password == pass else {
            throw AuthError.invalid
        }
        loggedInUser = user
    }
    
//    func register(user: String, pass: String) throws {
//        guard !hasSavedCreds else { throw AuthError.alreadyExists }
//        try KeychainHelper.save(username: user, password: pass)
//        loggedInUser = user
//    }
    
    /// End the session – but KEEP the Keychain item
        func logout() {
            loggedInUser = nil                // ← just end session
            // (do NOT call KeychainHelper.delete() here)
        }
    
//    enum AuthError: LocalizedError {
//        case noSavedCreds, invalid, alreadyExists
//        var errorDescription: String? {
//            switch self {
//            case .noSavedCreds:   return "No credentials in Keychain. Please register first."
//            case .invalid:        return "Wrong username or password."
//            case .alreadyExists:  return "Credentials already exist—use Log In."
//            }
//        }
//    }
    
    /// Optional helper when you really do want to erase the item
        func deleteCredentials() throws {
            try KeychainHelper.delete()
            loggedInUser = nil
        }
    
    func register(user: String, pass: String) throws {
        guard !hasSavedCreds else { throw AuthError.alreadyExists }
        guard !user.trimmingCharacters(in: .whitespaces).isEmpty,
              !pass.trimmingCharacters(in: .whitespaces).isEmpty
        else { throw AuthError.emptyFields }                    // 👈 NEW check
        
        try KeychainHelper.save(username: user, password: pass)
        loggedInUser = user
    }

    enum AuthError: LocalizedError {
        case noSavedCreds, invalid, alreadyExists, emptyFields   // 👈 add case
        
        var errorDescription: String? {
            switch self {
            case .noSavedCreds:   return "No credentials in Keychain. Please register first."
            case .invalid:        return "Wrong username or password."
            case .alreadyExists:  return "Credentials already exist—use Log In."
            case .emptyFields:    return "Username and password can’t be empty."
            }
        }
    }

}
