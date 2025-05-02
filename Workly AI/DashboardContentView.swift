//
//  DashboardContentView.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-03-29.
//
//
//import SwiftUI
//
//struct DashboardContentView: View {
//    var userName: String = "John Doe" // Replace with dynamic user data
//    
//    var body: some View {
//        VStack {
//            // App Bar
//            HStack {
//                Text("Dashboard")
//                    .font(.largeTitle)
//                    .bold()
//                
//                Spacer()
//                
//                HStack {
//                    Text(userName)
//                        .font(.headline)
//                    
//                    Image(systemName: "person.crop.circle.fill")
//                        .resizable()
//                        .frame(width: 40, height: 40)
//                        .foregroundColor(.blue)
//                }
//            }
//            .padding()
//            
//            // Page Swiper
//            TabView {
//                PageView(title: "Career Stats", description: "Track your career progress with AI insights.")
//                PageView(title: "Interview Tips", description: "Get AI-powered interview preparation tips.")
//                PageView(title: "Job Matches", description: "Find the best job matches based on your skills.")
//            }
//            .tabViewStyle(PageTabViewStyle())
//            .frame(height: 250) // Adjust height as needed
//            
//            Spacer()
//        }
//    }
//}
//
//// Page View for Swiper
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
//struct DashboardContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DashboardContentView()
//    }
//}
//




import SwiftUI

struct DashboardContentView: View {
    var userName: String = "John Doe"
    @State private var mockInterviewsPassed = 5
    @State private var questionsAnswered = 20
    @State private var chatbotInteractions = 35
    
    var body: some View {
        VStack {
            HStack {
                Text("Dashboard")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                HStack {
                    Text(userName)
                        .font(.headline)
                    
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            
            VStack {
                Text("Your Progress")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                HStack(spacing: 20) {
                    AnalyticsCard(title: "Mock Interviews Passed", value: "\(mockInterviewsPassed)")
                    AnalyticsCard(title: "Questions Answered", value: "\(questionsAnswered)")
                }
                .padding()
                
                HStack(spacing: 20) {
                    AnalyticsCard(title: "Chatbot Interactions", value: "\(chatbotInteractions)")
                }
                .padding()
            }
            
            // Page Swiper
            TabView {
                PageView(title: "Career Stats", description: "Track your career progress with AI insights.")
                PageView(title: "Interview Tips", description: "Get AI-powered interview preparation tips.")
                PageView(title: "Job Matches", description: "Find the best job matches based on your skills.")
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 250)
            .padding()
            
            Spacer()
        }
    }
}

struct PageView: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .bold()
            
            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(10)
        .padding()
    }
}

struct AnalyticsCard: View {
    var title: String
    var value: String
    
    var body: some View {
        VStack {
            Text(value)
                .font(.largeTitle)
                .bold()
                .foregroundColor(.blue)
            
            Text(title)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .frame(width: 150, height: 100)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct DashboardContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardContentView()
    }
}
