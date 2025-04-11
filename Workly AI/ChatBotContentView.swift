//
//  ChatBotContentView.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-04-02.
//

import SwiftUI

struct ChatBotContentView: View {
    @State private var userMessage = ""
    @State private var botResponse = "Hello! How can I assist you with your career today?"
    @State private var jobSuggestions: [String] = [] // List to store job suggestions
    
    let witService = WitAIService()
    
    // User online status
    @State private var isOnline = true
    
    var body: some View {
        VStack {
            // App Bar
            HStack {
                Text("Workly.AI Live")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                HStack {
                    // Online status
                    Circle()
                        .fill(isOnline ? Color.green : Color.red)
                        .frame(width: 10, height: 10)
                    
                    Text(isOnline ? "Online" : "Offline")
                        .font(.headline)
                        .foregroundColor(isOnline ? .green : .red)
                    
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            
            // Chat Screen
            ScrollView {
                VStack(spacing: 20) {
                    // Bot's message
                    Text(botResponse)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // User's message
                    Text(userMessage)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    // Job Suggestions (Pills or Links)
                    if !jobSuggestions.isEmpty {
                        Text("Based on our conversation, here are some job suggestions:")
                            .font(.headline)
                            .padding(.top)
                        
                        WrapView(items: jobSuggestions) { suggestion in
                            Button(action: {
                                // Handle job suggestion click
                                print("Selected: \(suggestion)")
                            }) {
                                Text(suggestion)
                                    .padding(8)
                                    .background(Color.blue.opacity(0.2))
                                    .cornerRadius(15)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                    }
                }
                .padding()
            }
            
            // Message Input Field and Send Button
            HStack {
                TextField("Type your message", text: $userMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: sendMessage) {
                    Text("Send")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .padding()
        .onAppear {
            // Initialize the chatbot with a friendly greeting
            botResponse = "Hi there! Tell me what kind of job you're looking for, and I'll help you find it."
        }
    }
    
    func sendMessage() {
        // Simulating bot's message after user sends a message
        botResponse = "Great! I found these jobs for you based on your interests."
        jobSuggestions = [
            "Software Engineer at XYZ Corp",
            "Data Scientist at ABC Inc.",
            "Product Manager at Tech Co."
        ]
        
        userMessage = "" // Clear the text field
    }
}

// Preview for ChatBotContentView
struct ChatBotContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChatBotContentView()
    }
}
