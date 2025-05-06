//
//  KeychainHelper.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-06.
//


import Foundation
import Security

struct KeychainHelper {
    private static let service = "com.yourcompany.worklyai"   // ← must be identical


    static func save(username: String, password: String) throws {
        let query: [String: Any] = [
            kSecClass            as String: kSecClassGenericPassword,
            kSecAttrService      as String: service,
            kSecAttrAccount      as String: username,
            kSecValueData        as String: password.data(using: .utf8)!,
            kSecAttrAccessible   as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        SecItemDelete(query as CFDictionary)                 // replace
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError(status: status) }
    }

    static func read() throws -> (username: String, password: String)? {
        let query: [String: Any] = [
            kSecClass               as String: kSecClassGenericPassword,
            kSecAttrService         as String: service,
            kSecReturnAttributes    as String: true,
            kSecReturnData          as String: true,
            kSecMatchLimit          as String: kSecMatchLimitOne
        ]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecItemNotFound { return nil }
        guard status == errSecSuccess,
              let dict  = item as? [String: Any],
              let user  = dict[kSecAttrAccount as String] as? String,
              let data  = dict[kSecValueData  as String] as? Data,
              let pass  = String(data: data, encoding: .utf8)
        else { throw KeychainError(status: status) }
        return (user, pass)
    }

    // optional modern alias
    static func load() throws -> (username: String, password: String)? { try read() }

    static func delete() throws {
        let q: [String: Any] = [
            kSecClass       as String: kSecClassGenericPassword,
            kSecAttrService as String: service
        ]
        let status = SecItemDelete(q as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound
        else { throw KeychainError(status: status) }
    }
    
    
    // MARK: – Enumerate every generic‑password item your app can see
    static func readAll() throws -> [(account: String, service: String, password: String)] {
        let query: [String: Any] = [
            kSecClass            as String: kSecClassGenericPassword,
            kSecReturnAttributes as String: true,
            kSecReturnData       as String: true,
            kSecMatchLimit       as String: kSecMatchLimitAll
        ]
        
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecItemNotFound { return [] }
        guard status == errSecSuccess, let array = result as? [[String: Any]] else {
            throw KeychainError(status: status)
        }
        
        return array.compactMap { dict in
            guard
                let account = dict[kSecAttrAccount as String] as? String,
                let service = dict[kSecAttrService as String] as? String,
                let data    = dict[kSecValueData  as String] as? Data,
                let pass    = String(data: data, encoding: .utf8)
            else { return nil }
            return (account, service, pass)
        }
    }

    // MARK: – Delete every generic‑password item your app can see
    static func deleteAll() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword
        ]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError(status: status)
        }
    }

}

struct KeychainError: LocalizedError {
    let status: OSStatus
    var errorDescription: String? {
        SecCopyErrorMessageString(status, nil) as String? ??
        "Keychain error (\(status))"
    }
}
