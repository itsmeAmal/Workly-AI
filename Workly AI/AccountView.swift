import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Gradient backdrop
                LinearGradient(
                    colors: [
                        Color(#colorLiteral(red:0.16, green:0.28, blue:0.62, alpha:1)),
                        Color(#colorLiteral(red:0.46, green:0.27, blue:0.75, alpha:1))
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 32) {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 72))
                            .foregroundColor(.white.opacity(0.9))
                            .shadow(radius: 8)
                        
                        VStack(spacing: 16) {
                            Text("Account settings coming soon.")
                                .font(.title3.weight(.semibold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white.opacity(0.9))
                            
                            Text("We’re working hard to bring you personalized account controls. Stay tuned!")
                                .font(.callout)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white.opacity(0.8))
                                .padding(.horizontal, 16)
                        }
                        .padding(24)
                        .background(.thinMaterial)
                        .cornerRadius(24)
                        .shadow(color: .black.opacity(0.25), radius: 10, y: 4)
                        .padding(.horizontal, 24)
                    }
                    .padding(.vertical, 48)
                }
            }
            .navigationTitle("Account")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
