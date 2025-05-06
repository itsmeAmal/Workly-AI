
import Foundation
import Security

/// Very small helper for saving / reading / deleting a single credential pair.
/// You can extend it (e.g. add update, keychain sharing, access control, etc.).
struct KeychainHelper {
    
    private static let service = Bundle.main.bundleIdentifier ?? "KeychainDemo"
    
    // MARK: – Public API
    static func save(username: String, password: String) throws {
        let account   = username
        let secret    = password.data(using: .utf8)!
        
        // Build an "add" query
        let addQuery: [String : Any] = [
            kSecClass            as String: kSecClassGenericPassword,
            kSecAttrService      as String: service,
            kSecAttrAccount      as String: account,
            kSecValueData        as String: secret,
            kSecAttrAccessible   as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        
        // If the item exists already, SecItemAdd will throw duplicate‑item,
        // so we delete first to keep the sample brief.
        SecItemDelete(addQuery as CFDictionary)
        
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError(status: status)
        }
    }
    
    static func read() throws -> (username: String, password: String)? {
        let query: [String : Any] = [
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
              let result = item as? [String : Any],
              let account = result[kSecAttrAccount as String] as? String,
              let data    = result[kSecValueData as String] as? Data,
              let password = String(data: data, encoding: .utf8)
        else {
            throw KeychainError(status: status)
        }
        return (account, password)
    }
    
    static func delete() throws {
        let query: [String : Any] = [
            kSecClass       as String: kSecClassGenericPassword,
            kSecAttrService as String: service
        ]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError(status: status)
        }
    }
}

/// Tiny wrapper that converts OSStatus to a Swift Error.
struct KeychainError: LocalizedError {
    let status: OSStatus
    var errorDescription: String? {
        SecCopyErrorMessageString(status, nil) as String? ??
        "Unknown Keychain error (code \(status))"
    }
}
