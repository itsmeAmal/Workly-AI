import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            // 1. Gradient backdrop
            LinearGradient(
                colors: [
                    Color(#colorLiteral(red:0.08, green:0.12, blue:0.32, alpha:1)), // deep navy
                    Color(#colorLiteral(red:0.28, green:0.14, blue:0.52, alpha:1))  // rich indigo
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // 2. Content
            ScrollView(showsIndicators: false) {
                VStack(spacing: 32) {
                    
                    // Icon & Title
                    VStack(spacing: 12) {
                        Image(systemName: "info.circle.fill")
                            .font(.system(size: 72))
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(radius: 8)
                        
                        Text("Workly.AI")
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(.white)
                        
                        Text("Version 1.0 • © 2025 Devindi Jayawardena")
                            .font(.callout)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    // Scope description card
                    VStack(alignment: .leading, spacing: 20) {
                        Text("What is Workly.AI?")
                            .font(.title3.weight(.semibold))
                            .foregroundColor(.white)
                        
                        Text("""
Workly.AI is your intelligent career companion, combining advanced AI and user-centered design to help you:
• Find the perfect job matches based on your skills and preferences  
• Practice mock interviews with AI-generated questions and track your progress  
• Chat with our career-advisor bot for personalized tips and guidance  
• Monitor your performance with interactive dashboards and analytics  
• Securely store your profile and credentials using Apple Keychain  
""")
                            .font(.body)
                            .foregroundColor(.white.opacity(0.9))
                    }
                    .padding(24)
                    .background(.thinMaterial)
                    .cornerRadius(24)
                    .shadow(color: .black.opacity(0.25), radius: 10, y: 4)
                    .padding(.horizontal, 24)
                    
                    // Contact / Feedback line
                    Text("Questions or feedback? Reach us at support@workly.ai")
                        .font(.footnote)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 24)
                        .padding(.bottom, 48)
                }
                .padding(.top, 48)
            }
        }
        .navigationTitle("About")
    }
}
