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

//struct JobPillViewModel: Identifiable {
//    let id = UUID()
//    let title: String
//    let location: String
//    let company: String
//}

// MARK: - ViewModel

//class ChatBotViewModel: ObservableObject {
//    @Published var userInput: String = ""
//    @Published var messages: [ChatMessage] = []
//    @Published var isLoading: Bool = false
//    @Published var jobPills: [JobPillViewModel] = []
//
//    init() {
//        messages.append(ChatMessage(role: .assistant, content: "👋 Hi there! I’m Workly.AI. Tell me what job you're looking for, and I’ll find some options for you."))
//    }
//
//    func sendMessage() {
//        let input = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
//        guard !input.isEmpty else { return }
//
//        messages.append(ChatMessage(role: .user, content: input))
//        userInput = ""
//        isLoading = true
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            if let data = JobService.shared.getJobDataFromWitAI(userQuery: input) {
//                let jobs = parseJobs(jsonData: data)
//
//                DispatchQueue.main.async {
//                    self.isLoading = false
//                    if jobs.isEmpty {
//                        self.messages.append(ChatMessage(role: .assistant, content: "Hmm, I couldn’t find any jobs matching that search. Maybe try changing your job title or location?"))
//                        self.jobPills = [] // Remove old pills if new search has no results
//                    } else {
//                        self.messages.append(ChatMessage(role: .assistant, content: "🎉 Great news! I found some job openings on Adzuna. Here are a few you might like:"))
//
//                        let pills = jobs.prefix(5).map { job in
//                            JobPillViewModel(
//                                title: job.title,
//                                location: job.location.displayName,
//                                company: "Adzuna"
//                            )
//                        }
//
//                        self.jobPills = pills // Update pills with new results
//                    }
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self.messages.append(ChatMessage(role: .assistant, content: "Oops! Something went wrong while fetching jobs."))
//                    self.isLoading = false
//                    self.jobPills = [] // Clear pills if request fails
//                }
//            }
//        }
//    }
//}

// MARK: - ChatBot View

struct ChatBotContentView: View {
    @StateObject private var viewModel = ChatBotViewModel()

    var body: some View {
        VStack(spacing: 0) {
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
                                        .cornerRadius(10)
                                        .foregroundColor(.black)
                                } else {
                                    Text(message.content)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
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

            // Job Pills Section
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
                .disabled(viewModel.userInput.trimmingCharacters(in: .whitespaces).isEmpty || viewModel.isLoading)
            }
            .padding()
        }
    }
}

