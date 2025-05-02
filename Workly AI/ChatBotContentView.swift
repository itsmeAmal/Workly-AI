import SwiftUI

// MARK: - Models

struct ChatMessage: Identifiable {
    let id = UUID()
    let role: Role
    let content: String

    enum Role {
        case user
        case assistant
    }
}
//
//struct ChatBotContentView: View {
//    @StateObject private var viewModel = ChatBotViewModel()
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 0) {
//                ScrollViewReader { scrollViewProxy in
//                    ScrollView {
//                        LazyVStack(alignment: .leading, spacing: 10) {
//                            ForEach(viewModel.messages) { message in
//                                HStack {
//                                    if message.role == .user {
//                                        Spacer()
//                                        Text(message.content)
//                                            .padding()
//                                            .background(Color.blue.opacity(0.2))
//                                            .cornerRadius(10)
//                                            .foregroundColor(.black)
//                                    } else {
//                                        Text(message.content)
//                                            .padding()
//                                            .background(Color.gray.opacity(0.2))
//                                            .cornerRadius(10)
//                                            .foregroundColor(.black)
//                                        Spacer()
//                                    }
//                                }
//                                .padding(.horizontal)
//                            }
//
//                            if viewModel.isLoading {
//                                HStack {
//                                    ProgressView().padding(.leading)
//                                    Spacer()
//                                }
//                            }
//                        }
//                        .onChange(of: viewModel.messages.count) { _ in
//                            withAnimation {
//                                scrollViewProxy.scrollTo(
//                                    viewModel.messages.last?.id, anchor: .bottom
//                                )
//                            }
//                        }
//                    }
//                }
//
//                // Job Pills Section
//                if !viewModel.jobPills.isEmpty {
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 10) {
//                            ForEach(viewModel.jobPills) { pill in
//                                VStack(alignment: .leading, spacing: 5) {
//                                    Text("Adzuna")
//                                        .font(.caption2)
//                                        .foregroundColor(.gray)
//                                    Text(pill.title)
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(.blue)
//                                    Text(pill.location)
//                                        .font(.caption)
//                                        .foregroundColor(.black)
//                                }
//                                .padding()
//                                .background(Color.blue.opacity(0.1))
//                                .cornerRadius(12)
//                                .shadow(radius: 1)
//                            }
//                        }
//                        .padding(.horizontal)
//                        .padding(.top, 5)
//                    }
//                }
//
//                Divider()
//
//                HStack {
//                    TextField("Ask something...", text: $viewModel.userInput)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .disabled(viewModel.isLoading)
//
//                    Button("Send") {
//                        viewModel.sendMessage()
//                    }
//                    .disabled(
//                        viewModel.userInput.trimmingCharacters(in: .whitespaces)
//                            .isEmpty || viewModel.isLoading)
//                }
//                .padding()
//            }
//        }
//        .navigationTitle("Workly.AI Chatbot Live")
//    }
//}

import SwiftUI

struct ChatBotContentView: View {
    @StateObject private var viewModel = ChatBotViewModel()

    var body: some View {
        VStack(spacing: 0) {

            // 🔷 Flutter-style AppBar
            HStack {
                Spacer()
                Text("Workly.AI Chatbot Live")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            }
            .padding()
            .background(Color("27548A"))

            // 🔽 Main Chat Content
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.messages) { message in
                            HStack {
                                if message.role == .user {
                                    Spacer()
                                    Text(message.content)
                                        .padding()
                                        .background(Color.blue.opacity(0.2))
                                        .cornerRadius(10, corners: [.topLeft, .topRight, .bottomLeft]) // bottomRight uncurved
                                        .foregroundColor(.black)
                                } else {
                                    Text(message.content)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10, corners: [.topLeft, .topRight, .bottomRight]) // bottomLeft uncurved
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
                            scrollViewProxy.scrollTo(viewModel.messages.last?.id, anchor: .bottom)
                        }
                    }
                }
            }

            // 🔹 Job Pills Section
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

            // 🔻 Chat Input
            HStack {
                TextField("Ask something...", text: $viewModel.userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(viewModel.isLoading)

                Button("Send") {
                    viewModel.sendMessage()
                }
                .disabled(viewModel.userInput.trimmingCharacters(in: .whitespaces).isEmpty || viewModel.isLoading)
            }
            .padding()
        }
        .background(Color("001F3F").ignoresSafeArea()) // navy blue background
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
