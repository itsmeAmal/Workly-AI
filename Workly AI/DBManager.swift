//
//  DBManager.swift
//  Workly AI
//
//  Created by Devindi Jayawardena on 2025-05-02.
//


import Foundation
import SQLite3

let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)

final class DBManager {
    static let shared = DBManager()
    private let dbURL: URL
    private var db: OpaquePointer?

    private init() {
        let docs = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask).first!
        dbURL = docs.appendingPathComponent("users.sqlite")
        openDatabase()
        createTable()
    }
    deinit { sqlite3_close(db) }

    // MARK:‑ Low‑level helpers
    private func openDatabase() {
        guard sqlite3_open(dbURL.path, &db) == SQLITE_OK else {
            print("❌ Unable to open DB"); return
        }
    }

    private func exec(sql: String,
                      bind: ((OpaquePointer?) -> Void)? = nil) -> Bool {
        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
            print("❌ Prepare failed – \(errorMessage)"); return false
        }
        bind?(stmt)
        let ok = sqlite3_step(stmt) == SQLITE_DONE
        if !ok { print("❌ Step failed – \(errorMessage)") }
        sqlite3_finalize(stmt)
        return ok
    }

    private var errorMessage: String {
        String(cString: sqlite3_errmsg(db))
    }

    // MARK:‑ Schema
    private func createTable() {
        let sql = """
            CREATE TABLE IF NOT EXISTS users(
                id   INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                dob   TEXT,          -- ISO‑8601 yyyy-MM-dd
                email TEXT
            );
        """
        _ = exec(sql: sql)
    }

//    private func createTable() {
//        let sql = """
//            CREATE TABLE IF NOT EXISTS users(
//                id  INTEGER PRIMARY KEY AUTOINCREMENT,
//                name  TEXT    NOT NULL,
//                dob   TEXT,
//                email   TEXT,
//                contactNo  TEXT  
//            );
//        """
//        _ = exec(sql: sql)
//    }

    
    // ISO formatter once for the whole file
    private let iso: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withFullDate]
        return f
    }()

    // MARK: ‑ Insert
    func insert(name: String, dob: Date, email: String) {
        let sql = "INSERT INTO users (name, dob, email) VALUES (?,?,?)"
        _ = exec(sql: sql) { [self] stmt in
            sqlite3_bind_text(stmt, 1, (name  as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 2, (iso.string(from: dob) as NSString).utf8String,
                              -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 3, (email as NSString).utf8String, -1, SQLITE_TRANSIENT)
            //sqlite3_bind_text(stmt, 4, (contactNo as NSString).utf8String, -1, SQLITE_TRANSIENT)
        }
    }
    

    // MARK: ‑ Read
    func fetchUsers() -> [User] {
        let sql = "SELECT id, name, dob, email FROM users ORDER BY id DESC"
        var stmt: OpaquePointer?
        var result = [User]()
        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else { return result }

        while sqlite3_step(stmt) == SQLITE_ROW {
            let id    = sqlite3_column_int(stmt, 0)
            let name  = String(cString: sqlite3_column_text(stmt, 1))
            let dobStr = String(cString: sqlite3_column_text(stmt, 2))
            let email = String(cString: sqlite3_column_text(stmt, 3))

            let dob = iso.date(from: dobStr) ?? Date()
            result.append(User(id: id, name: name, dob: dobStr, email: email))
        }
        sqlite3_finalize(stmt)
        return result
    }
    
    
    
    

    // MARK: ‑ Update
//    func update(user: User) {
//        let sql = "UPDATE users SET name=?, dob=?, email=? WHERE id=?"
//        _ = exec(sql: sql) { [self] stmt in
//            sqlite3_bind_text(stmt, 1, (user.name  as NSString).utf8String, -1, SQLITE_TRANSIENT)
//            sqlite3_bind_text(stmt, 2, (iso.string(from: user.dob) as NSString).utf8String,
//                              -1, SQLITE_TRANSIENT)
//            sqlite3_bind_text(stmt, 3, (user.email as NSString).utf8String, -1, SQLITE_TRANSIENT)
//            sqlite3_bind_int(stmt, 4, user.id)
//        }
//    }

    
    
    
    
    
    
    
    
    
    
    // MARK:‑ CRUD
//    func insert(name: String, age: Int) {
//        let sql = "INSERT INTO users (name, age) VALUES (?,?)"
//        _ = exec(sql: sql) { stmt in
//            sqlite3_bind_text(stmt, 1,
//                              (name as NSString).utf8String,
//                              -1,
//                              SQLITE_TRANSIENT)
//            sqlite3_bind_int(stmt, 2, Int32(age))
//        }
//    }

    
    
//    func insert(name: String, age: String) {
//        let sql = "INSERT INTO users (name, age) VALUES (?,?)"
//        _ = exec(sql: sql) { stmt in
//            sqlite3_bind_text(stmt, 1,
//                              (name as NSString).utf8String,
//                              -1,
//                              SQLITE_TRANSIENT)
//            sqlite3_bind_text(stmt, 2,
//                              (age as NSString).utf8String,
//                              -1,
//                              SQLITE_TRANSIENT)
//            //sqlite3_bind_int(stmt, 2, age)
//        }
//    }
    
    
    
//    func fetchUsers() -> [User] {
//        let sql = "SELECT id, name, age FROM users ORDER BY id DESC"
//        var stmt: OpaquePointer?
//        var out = [User]()
//        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else {
//            print("❌ Prepare failed – \(errorMessage)"); return out
//        }
//        while sqlite3_step(stmt) == SQLITE_ROW {
//            let id  = sqlite3_column_int(stmt, 0)
//            let txt = sqlite3_column_text(stmt, 1)
//            let nm  = txt != nil ? String(cString: txt!) : "(null)"
//            let age = Int(sqlite3_column_int(stmt, 2))
//            out.append(User(id: id, name: nm, age: age))
//        }
//        sqlite3_finalize(stmt)
//        return out
//    }

    
    
    
//    func update(user: User) {
//        let sql = "UPDATE users SET name=?, age=? WHERE id=?"
//        _ = exec(sql: sql) { stmt in
//            // ✅ make SQLite copy the Swift string safely
//            sqlite3_bind_text(stmt, 1,
//                              (user.name as NSString).utf8String,
//                              -1,
//                              SQLITE_TRANSIENT)
//
//            sqlite3_bind_int(stmt, 2, Int32(user.age))
//            sqlite3_bind_int(stmt, 3, user.id)
//        }
//    }
    
    

        
    func delete(id: Int32) {
        let sql = "DELETE FROM users WHERE id=?"
        _ = exec(sql: sql) { stmt in
            sqlite3_bind_int(stmt, 1, id)
        }
    }

}
