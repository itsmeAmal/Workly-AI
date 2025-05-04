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
        //dropTable()
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
    
    
    private func dropTable() {
        let sql = """
            DROP TABLE usrr;
        """
        _ = exec(sql: sql)
    }

    
    // MARK:‑ Schema
    private func createTable() {
        let sql = """
            CREATE TABLE IF NOT EXISTS usrr(
                id   INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                dob   TEXT,          -- ISO‑8601 yyyy-MM-dd
                email TEXT,
                contactNo   TEXT,
                educationLevel  TEXT,
                gender     TEXT,
                isJobSeeker   INTEGER
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
//        _ = exec(sql: "ALTER TABLE user_tabl ADD COLUMN contactNo TEXT")
//    }

    
    // ISO formatter once for the whole file
    private let iso: ISO8601DateFormatter = {
        let f = ISO8601DateFormatter()
        f.formatOptions = [.withFullDate]
        return f
    }()
    
    
    
    func insert(name: String, dob: Date, email: String, contactNo: String, educationLevel: String, gender: String, isJobSeeker: Bool) {
        let sql = "INSERT INTO usrr (name, dob, email, contactNo, educationLevel, gender, isJobSeeker) VALUES (?,?,?,?,?,?,?)"
        _ = exec(sql: sql) { [self] stmt in
            sqlite3_bind_text(stmt, 1, (name as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 2, (iso.string(from: dob) as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 3, (email as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 4, (contactNo as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 5, (educationLevel as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 6, (gender as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_int (stmt, 7, isJobSeeker ? 1 : 0)
        }
    }

    
    
//    func fetchUsers() -> [User] {
//        let sql = "SELECT id, name, dob, email FROM users ORDER BY id DESC"
//        var stmt: OpaquePointer?
//        var result = [User]()
//        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else { return result }
//
//        while sqlite3_step(stmt) == SQLITE_ROW {
//            let id    = sqlite3_column_int(stmt, 0)
//            let name  = String(cString: sqlite3_column_text(stmt, 1))
//            let dobStr = String(cString: sqlite3_column_text(stmt, 2))
//            let email = String(cString: sqlite3_column_text(stmt, 3))
//
//            let dob = iso.date(from: dobStr) ?? Date()
//            result.append(User(id: id, name: name, dob: dobStr, email: email))
//        }
//        sqlite3_finalize(stmt)
//        return result
//    }
    
    
    // MARK: ‑ Read
    func fetchUsers() -> [User] {
        let sql = "SELECT id, name, dob, email, contactNo, educationLevel, gender, isJobSeeker FROM usrr ORDER BY id DESC"
        var stmt: OpaquePointer?
        var out = [User]()

        guard sqlite3_prepare_v2(db, sql, -1, &stmt, nil) == SQLITE_OK else { return out }

        while sqlite3_step(stmt) == SQLITE_ROW {
            let id   = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let dob  = String(cString: sqlite3_column_text(stmt, 2))
            let mail = String(cString: sqlite3_column_text(stmt, 3))
            let phone = String(cString: sqlite3_column_text(stmt, 4))
            let educationLevel = String(cString: sqlite3_column_text(stmt, 5))
            let gender = String(cString: sqlite3_column_text(stmt, 6))
            let seeker = sqlite3_column_int(stmt, 7) == 1

            out.append(
                User(
                    id: id,
                    name: name,
                    dob: dob,
                    email: mail,
                    contactNo: phone,
                    educationLevel: educationLevel,
                    gender: gender,
                    isJobSeeker: seeker
                )
            )
        }
        sqlite3_finalize(stmt)
        return out
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

    
    
    // MARK: – Update
    func update(user: User) {
        let sql = """
            UPDATE usrr
            SET name = ?, dob = ?, email = ?, contactNo = ?,
                        educationLevel = ?, gender = ?, isJobSeeker = ?
            WHERE id = ?
        """
        _ = exec(sql: sql) { stmt in
            sqlite3_bind_text(stmt, 1, (user.name        as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 2, (user.dob         as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 3, (user.email       as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 4, (user.contactNo   as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 5, (user.educationLevel   as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_text(stmt, 6, (user.gender      as NSString).utf8String, -1, SQLITE_TRANSIENT)
            sqlite3_bind_int (stmt, 7, user.isJobSeeker ? 1 : 0)
            sqlite3_bind_int (stmt, 8, user.id)
        }
        // ping listeners so ProfileView auto‑reloads
        //NotificationCenter.default.post(name: .userDataChanged, object: nil)
    }

    
  
    func delete(id: Int32) {
        let sql = "DELETE FROM usrr WHERE id=?"
        _ = exec(sql: sql) { stmt in
            sqlite3_bind_int(stmt, 1, id)
        }
    }

}
