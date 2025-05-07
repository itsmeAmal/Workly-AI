import SwiftUI

struct ChatMessage: Identifiable {
    let id = UUID()
    let role: Role
    let content: String

    enum Role {
        case user
        case assistant
    }
}

struct ChatBotContentView: View {
    @StateObject private var viewModel = ChatBotViewModel()

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 8) {
                Circle()
                    .fill(Color.green.opacity(0.7))
                    .frame(width: 10, height: 10)
                Text("Workly.AI Live Chatbot")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color(hex: "102E50"))

            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.messages) { message in
                            HStack {
                                if message.role == .user {
                                    Spacer()
                                    Text(message.content)
                                        .padding()
                                        .background(Color.white.opacity(1))
                                        .cornerRadius(
                                            10,
                                            corners: [
                                                .topLeft, .topRight,
                                                .bottomLeft,
                                            ]
                                        )  // bottomRight uncurved
                                        .foregroundColor(.black)
                                } else {
                                    Text(message.content)
                                        .padding()
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(
                                            10,
                                            corners: [
                                                .topLeft, .topRight,
                                                .bottomRight,
                                            ]
                                        )  // bottomLeft uncurved
                                        .foregroundColor(.black)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }

                        if viewModel.isLoading {
                            HStack {
                                ProgressView().padding(.leading)
                                Spacer()
                            }
                        }
                    }
                    .onChange(of: viewModel.messages.count) { _ in
                        withAnimation {
                            scrollViewProxy.scrollTo(
                                viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                }
            }

            if !viewModel.jobPills.isEmpty {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.jobPills) { pill in
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Adzuna")
                                    .font(.caption2)
                                    .foregroundColor(.gray)
                                Text(pill.title)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.blue)
                                Text(pill.location)
                                    .font(.caption)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(12)
                            .shadow(radius: 1)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 5)
                }
            }

            Divider()

            HStack {
                TextField("Ask something...", text: $viewModel.userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(viewModel.isLoading)

                Button("Send") {
                    viewModel.sendMessage()
                }
                .disabled(
                    viewModel.userInput.trimmingCharacters(in: .whitespaces)
                        .isEmpty || viewModel.isLoading)
            }
            .padding()
        }
        .background(Color(hex: "FFFFFF").ignoresSafeArea())  // navy blue background #FFFFFF
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
