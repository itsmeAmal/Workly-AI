//
//  ChatBotContentView.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-04-02.
//
//
//import SwiftUI
//
//struct ChatBotContentView: View {
//    @State private var userMessage = ""
//    @State private var botResponse = "Hello! How can I assist you with your career today?"
//    @State private var jobSuggestions: [String] = [] // List to store job suggestions
//    
//    let witService = WitAIService()
//    
//    // User online status
//    @State private var isOnline = true
//    
//    var body: some View {
//        VStack {
//            // App Bar
//            HStack {
//                Text("Workly.AI Live")
//                    .font(.title2)
//                    .bold()
//                
//                Spacer()
//                
//                HStack {
//                    // Online status
//                    Circle()
//                        .fill(isOnline ? Color.green : Color.red)
//                        .frame(width: 10, height: 10)
//                    
//                    Text(isOnline ? "Online" : "Offline")
//                        .font(.headline)
//                        .foregroundColor(isOnline ? .green : .red)
//                    
//                    Image(systemName: "person.crop.circle.fill")
//                        .resizable()
//                        .frame(width: 40, height: 40)
//                        .foregroundColor(.blue)
//                }
//            }
//            .padding()
//            
//            // Chat Screen
//            ScrollView {
//                VStack(spacing: 20) {
//                    // Bot's message
//                    Text(botResponse)
//                        .padding()
//                        .background(Color.gray.opacity(0.1))
//                        .cornerRadius(10)
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    
//                    // User's message
//                    Text(userMessage)
//                        .padding()
//                        .background(Color.blue.opacity(0.1))
//                        .cornerRadius(10)
//                        .frame(maxWidth: .infinity, alignment: .trailing)
//                    
//                    // Job Suggestions (Pills or Links)
//                    if !jobSuggestions.isEmpty {
//                        Text("Based on our conversation, here are some job suggestions:")
//                            .font(.headline)
//                            .padding(.top)
//                        
//                        WrapView(items: jobSuggestions) { suggestion in
//                            Button(action: {
//                                // Handle job suggestion click
//                                print("Selected: \(suggestion)")
//                            }) {
//                                Text(suggestion)
//                                    .padding(8)
//                                    .background(Color.blue.opacity(0.2))
//                                    .cornerRadius(15)
//                                    .foregroundColor(.blue)
//                            }
//                        }
//                        .padding()
//                    }
//                }
//                .padding()
//            }
//            
//            // Message Input Field and Send Button
//            HStack {
//                TextField("Type your message", text: $userMessage)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//                
//                Button(action: sendMessage) {
//                    Text("Send")
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
//                .padding()
//            }
//        }
//        .padding()
//        .onAppear {
//            // Initialize the chatbot with a friendly greeting
//            botResponse = "Hi there! Tell me what kind of job you're looking for, and I'll help you find it."
//        }
//    }
//    
////    func sendMessage() {
////        let messageToSend = userMessage.trimmingCharacters(in: .whitespacesAndNewlines)
////        guard !messageToSend.isEmpty else { return }
////
////        botResponse = "Let me think about that..."
////
////        witService.processMessage(messageToSend) { result in
////            DispatchQueue.main.async {
////                guard let result = result else {
////                    botResponse = "Sorry, I didn’t get that. Can you try again?"
////                    return
////                }
////
////                let what = result.entities["what"]?.first?.value
////                let whereLoc = result.entities["where"]?.first?.value
////                let country = result.entities["country"]?.first?.value ?? "us"
////                let resultsPerPage = result.entities["results_per_page"]?.first?.value ?? "5"
////
////                // Build API query
////                var query = "https://api.adzuna.com/v1/api/jobs/\(country)/search/1?app_id=YOUR_APP_ID&app_key=YOUR_APP_KEY"
////                query += "&results_per_page=\(resultsPerPage)"
////
////                if let what = what?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
////                    query += "&what=\(what)"
////                }
////
////                if let whereLoc = whereLoc?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
////                    query += "&where=\(whereLoc)"
////                }
////
////                // Fetch job suggestions
////                fetchJobs(from: query)
////
////                userMessage = ""
////            }
////        }
////    }
//    
//    func sendMessage() {
//        let messageToSend = userMessage.trimmingCharacters(in: .whitespacesAndNewlines)
//        guard !messageToSend.isEmpty else { return }
//
//        botResponse = "Let me think about that..."
//
//        witService.processMessage(messageToSend) { result in
//            DispatchQueue.main.async {
//                guard let result = result else {
//                    botResponse = "Sorry, I didn’t get that. Can you try again?"
//                    return
//                }
//
//                // Check intent
//                if let intent = result.intents.first, intent.name == "get_job_suggestions", intent.confidence > 0.6 {
//
//                    let jobTitle = result.entities["job_title"]?.first?.value
//                    let location = result.entities["wit/location"]?.first?.value
//                    let country = result.entities["country"]?.first?.value ?? "us"
//                    let resultsPerPage = result.entities["results_per_page"]?.first?.value ?? "5"
//                    // datetime can be handled if needed later
//
//                    // Build API query
//                    var query = "https://api.adzuna.com/v1/api/jobs/\(country)/search/1?app_id=9535593c&app_key=f2aed4b68604d38d366a4c39f1ec1e1c"
//                    query += "&results_per_page=\(resultsPerPage)"
//
//                    if let jobTitle = jobTitle?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
//                        query += "&what=\(jobTitle)"
//                    }
//
//                    if let location = location?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
//                        query += "&where=\(location)"
//                    }
//
//                    // Fetch job suggestions
//                    fetchJobs(from: query)
//
//                    userMessage = "" // Clear the input field
//
//                } else {
//                    botResponse = "I'm not sure what kind of job you're looking for. Can you rephrase?"
//                }
//            }
//        }
//    }
//
//    
//    
//    func fetchJobs(from urlString: String) {
//        guard let url = URL(string: urlString) else {
//            botResponse = "Hmm, that didn’t work. Try a different query?"
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            DispatchQueue.main.async {
//                guard let data = data, error == nil else {
//                    botResponse = "I ran into a problem fetching jobs."
//                    return
//                }
//
//                do {
//                    if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
//                       let results = json["results"] as? [[String: Any]] {
//                        self.jobSuggestions = results.prefix(5).compactMap {
//                            guard let title = $0["title"] as? String,
//                                  let company = ($0["company"] as? [String: Any])?["display_name"] as? String
//                            else { return nil }
//                            return "\(title) at \(company)"
//                        }
//                        botResponse = "Here are some jobs I found for you!"
//                    } else {
//                        botResponse = "I couldn’t find any results. Try being more specific."
//                    }
//                } catch {
//                    botResponse = "Something went wrong while processing results."
//                }
//            }
//        }.resume()
//    }
//
//    
//    
//    
//
//}
//
//// Preview for ChatBotContentView
//struct ChatBotContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChatBotContentView()
//    }
//}
//
//


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
    @State private var userInput = ""
    @State private var messages: [ChatMessage] = []
    @State private var isLoading = false

    var body: some View {
        VStack {
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(messages) { message in
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
                        if isLoading {
                            HStack {
                                ProgressView()
                                    .padding(.leading)
                                Spacer()
                            }
                        }
                    }
                }
                .onChange(of: messages.count) { _ in
                    withAnimation {
                        scrollViewProxy.scrollTo(messages.last?.id, anchor: .bottom)
                    }
                }
            }

            Divider()

            HStack {
                TextField("Ask something...", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disabled(isLoading)

                Button("Send") {
                    sendMessage()
                }
                .disabled(userInput.trimmingCharacters(in: .whitespaces).isEmpty || isLoading)
            }
            .padding()
        }
    }

    private func sendMessage() {
        let input = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !input.isEmpty else { return }

        messages.append(ChatMessage(role: .user, content: input))
        userInput = ""
        isLoading = true

        DispatchQueue.global(qos: .userInitiated).async {
            if let data = JobService.shared.getJobDataFromWitAI(userQuery: input) {
                let jobs = parseJobs(jsonData: data)

                let responseText = jobs.isEmpty
                    ? "Sorry, I couldn't find any jobs."
                    : "Here are some jobs I found:\n" + jobs.map { "• \($0.title) at \($0.company.displayName)" }.joined(separator: "\n")

                DispatchQueue.main.async {
                    messages.append(ChatMessage(role: .assistant, content: responseText))
                    isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    messages.append(ChatMessage(role: .assistant, content: "Oops! Something went wrong while fetching jobs."))
                    isLoading = false
                }
            }
        }
    }
}
