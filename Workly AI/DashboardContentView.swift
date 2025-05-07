//
//  DashboardContentView.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-03-29.
//
//

import SwiftUI

//struct DashboardContentView: View {
//    // latest user list (if you need it for anything else)
//    @State private var users: [User] = []
//
//    // name shown top‑right
//    @State private var userName: String = "Guest"
//
//    @State private var mockInterviewsPassed = 5
//    @State private var questionsAnswered    = 20
//    @State private var chatbotInteractions  = 35
//
//    var body: some View {
//        VStack {
//            header
//            progressSection
//            carousel
//            Spacer()
//        }
//        .onAppear(perform: load)    // reload each visit
//        .onReceive(NotificationCenter.default
//                   .publisher(for: .userDataChanged)) { _ in load() } // reload on DB change
//    }
//
//    // MARK: – Subviews
//    private var header: some View {
//        HStack {
//            Text("Dashboard")
//                .font(.largeTitle)
//                .bold()
//
//            Spacer()
//
//            HStack {
//                Text(userName)
//                    .font(.headline)
//
//                Image(systemName: "person.crop.circle.fill")
//                    .resizable()
//                    .frame(width: 40, height: 40)
//                    .foregroundColor(.blue)
//            }
//        }
//        .padding()
//    }
//
//    private var progressSection: some View {
//        VStack {
//            Text("Your Progress")
//                .font(.title2)
//                .bold()
//                .padding(.top)
//
//            HStack(spacing: 20) {
//                AnalyticsCard(title: "Mock Interviews Passed",
//                              value: "\(mockInterviewsPassed)")
//                AnalyticsCard(title: "Questions Answered",
//                              value: "\(questionsAnswered)")
//            }
//            .padding()
//
//            HStack(spacing: 20) {
//                AnalyticsCard(title: "Chatbot Interactions",
//                              value: "\(chatbotInteractions)")
//            }
//            .padding()
//        }
//    }
//
//    private var carousel: some View {
//        TabView {
//            PageView(title: "Career Stats",
//                     description: "Track your career progress with AI insights.")
//            PageView(title: "Interview Tips",
//                     description: "Get AI‑powered interview preparation tips.")
//            PageView(title: "Job Matches",
//                     description: "Find the best job matches based on your skills.")
//        }
//        .tabViewStyle(PageTabViewStyle())
//        .frame(height: 250)
//        .padding()
//        .navigationBarBackButtonHidden(true)
//    }
//
//    // MARK: – Data loader
//    private func load() {
//        users = DBManager.shared.fetchUsers()
//        userName = users.first?.name ?? "Guest"   // grab newest user's name
//    }
//}
//
//
//
//struct PageView: View {
//    var title: String
//    var description: String
//    
//    var body: some View {
//        VStack {
//            Text(title)
//                .font(.title)
//                .bold()
//            
//            Text(description)
//                .font(.body)
//                .multilineTextAlignment(.center)
//                .padding()
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.gray.opacity(0.2))
//        .cornerRadius(10)
//        .padding()
//    }
//}
//
//
//struct AnalyticsCard: View {
//    var title: String
//    var value: String
//    
//    var body: some View {
//        VStack {
//            Text(value)
//                .font(.largeTitle)
//                .bold()
//                .foregroundColor(.blue)
//            
//            Text(title)
//                .font(.body)
//                .foregroundColor(.gray)
//                .multilineTextAlignment(.center)
//        }
//        .frame(width: 150, height: 100)
//        .background(Color.white)
//        .cornerRadius(10)
//        .shadow(radius: 5)
//    }
//}






import SwiftUI

struct DashboardContentView: View {
    // -------------- EXISTING STATE (unchanged) --------------
    @State private var users: [User] = []
    @State private var userName: String = "Guest"
    @State private var mockInterviewsPassed = 5
    @State private var questionsAnswered    = 20
    @State private var chatbotInteractions  = 35
    
    var body: some View {
        NavigationStack {
            ZStack {
                // — Gradient background —
                LinearGradient(
                    colors: [Color(#colorLiteral(red:0.16, green:0.28, blue:0.62, alpha:1)),
                             Color(#colorLiteral(red:0.46, green:0.27, blue:0.75, alpha:1))],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 32) {
                        header
                        progressSection
                        carousel
                    }
                    .padding(.vertical, 32)
                }
            }
            .navigationBarBackButtonHidden(true)
            .onAppear(perform: load)
            .onReceive(NotificationCenter.default.publisher(for: .userDataChanged)) { _ in load() }
        }
    }
    
    // MARK: UI sub‑components
    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Dashboard")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                Text("Hi, \(userName)!")
                    .font(.callout)
                    .foregroundColor(.white.opacity(0.85))
            }
            Spacer(minLength: 0)
            
            Image(systemName: "person.crop.circle")
                .font(.system(size: 48))
                .foregroundColor(.white.opacity(0.9))
                .overlay(
                    Circle()
                        .stroke(.white.opacity(0.3), lineWidth: 2)
                )
        }
        .padding(.horizontal, 24)
    }
    
    private var progressSection: some View {
        VStack(spacing: 24) {
            Text("Your Progress")
                .font(.title2.weight(.semibold))
                .foregroundColor(.white)
            
            // Grid of cards
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2),
                       spacing: 20) {
                AnalyticsCard(title: "Mock Interviews Passed",
                              value: "\(mockInterviewsPassed)",
                              symbol: "checkmark.seal")
                AnalyticsCard(title: "Questions Answered",
                              value: "\(questionsAnswered)",
                              symbol: "questionmark.circle")
                AnalyticsCard(title: "Chatbot Interactions",
                              value: "\(chatbotInteractions)",
                              symbol: "message.circle")
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var carousel: some View {
        TabView {
            PageView(
                symbol: "chart.bar.xaxis",
                title: "Career Stats",
                description: "Track your career progress with AI-driven insights."
            )
            PageView(
                symbol: "lightbulb",
                title: "Interview Tips",
                description: "Get AI‑powered preparation guidance."
            )
            PageView(
                symbol: "briefcase",
                title: "Job Matches",
                description: "Discover roles that fit your skills."
            )
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(height: 260)
        .padding(.horizontal, 16)
    }
    
    // -------------- EXISTING HELPER --------------
    private func load() {
        users    = DBManager.shared.fetchUsers()
        userName = users.first?.name ?? "Guest"
    }
}

// MARK: - PageView (carousel card)
struct PageView: View {
    var symbol: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: symbol)
                .font(.system(size: 48, weight: .semibold))
                .foregroundColor(.white)
                .shadow(radius: 10)
            
            Text(title)
                .font(.title3.weight(.bold))
                .foregroundColor(.white)
            
            Text(description)
                .font(.callout)
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.9))
                .padding(.horizontal, 12)
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.thinMaterial)
        .cornerRadius(24)
        .shadow(color: .black.opacity(0.25), radius: 10, y: 4)
        .padding(.vertical, 8)
    }
}

// MARK: - AnalyticsCard
struct AnalyticsCard: View {
    var title: String
    var value: String
    var symbol: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: symbol)
                .font(.system(size: 32, weight: .semibold))
                .foregroundColor(.white.opacity(0.9))
                .shadow(radius: 4)
            
            Text(value)
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)
            
            Text(title)
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundColor(.white.opacity(0.85))
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 140)
        .background(.thinMaterial)
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.25), radius: 8, y: 4)
    }
}




struct DashboardContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardContentView()
    }
}
