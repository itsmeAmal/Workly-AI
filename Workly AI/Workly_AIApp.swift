//
//  Workly_AIApp.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-03-29.
//

import SwiftUI

//@main
//struct Workly_AIApp: App {
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}


@main
struct Workly_AIApp: App {
    @StateObject private var session = SessionStore()
        
        var body: some Scene {
            WindowGroup {
                Group {
                    if session.loggedInUser == nil {
                        LoginView()
                    } else {
                        ContentView()          // ← your existing TabView
                    }
                }
                .environmentObject(session)
            }
        }
}


