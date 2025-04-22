//
//  ChatBotViewModel.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-04-19.
//

import Foundation
import SwiftUI

//class ChatBotViewModel: ObservableObject {
//    @Published var userInput = ""
//    @Published var messages: [ChatMessage] = []
//    @Published var isLoading = false
//    @Published var jobPills: [JobPillViewModel] = []
//
//    func sendMessage() {
//        let input = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
//        guard !input.isEmpty else { return }
//
//        messages.append(ChatMessage(role: .user, content: input))
//        let currentQuery = input // Capture before clearing
//        userInput = ""
//        isLoading = true
//
//        jobPills = []
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            if let data = JobService.shared.getJobDataFromWitAI(userQuery: currentQuery) {
//                let jobs = parseJobs(jsonData: data)
//
//                DispatchQueue.main.async {
//                    if jobs.isEmpty {
//                        self.messages.append(ChatMessage(
//                            role: .assistant,
//                            content: "Hmm, I couldn’t find any jobs matching your request. Maybe try tweaking the title or location?"
//                        ))
//
//                        self.jobPills = []
//                    } else {
//                        self.messages.append(ChatMessage(
//                            role: .assistant,
//                            content: "Awesome! I found some openings on Adzuna that match what you're looking for:"
//                        ))
//
//                        let pills = jobs.prefix(5).map { job in
//                            JobPillViewModel(
//                                title: job.title,
//                                location: job.location.displayName,
//                                company: "Adzuna"
//                            )
//                        }
//
//                        self.jobPills = pills
//                    }
//
//                    self.isLoading = false
//                }
//            } else {
//                DispatchQueue.main.async {
//                    self.messages.append(ChatMessage(
//                        role: .assistant,
//                        content: "Oops! Something went wrong while I was searching for jobs. Can you try again?"
//                    ))
//                    self.jobPills = [] // Ensure UI doesn't retain old pills
//                    self.isLoading = false
//                }
//            }
//        }
//    }
//    
//}

class ChatBotViewModel: ObservableObject {
    @Published var userInput = ""
    @Published var messages: [ChatMessage] = []
    @Published var isLoading = false
    @Published var jobPills: [JobPillViewModel] = []

    func sendMessage() {
        let input = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !input.isEmpty else { return }

        messages.append(ChatMessage(role: .user, content: input))
        let currentQuery = input // Capture before clearing
        userInput = ""
        isLoading = true
        jobPills = []

        DispatchQueue.global(qos: .userInitiated).async {
            let result = JobService.shared.getJobDataFromWitAI(userQuery: currentQuery)
            let intent = result.intent
            let data = result.data

            DispatchQueue.main.async {
                if intent == "greet_user" {
                    self.messages.append(ChatMessage(
                        role: .assistant,
                        content: "Hi there! Let me know what kind of job you're looking for, and where!"
                    ))
                    self.isLoading = false
                    return
                }

                guard let jsonData = data else {
                    self.messages.append(ChatMessage(
                        role: .assistant,
                        content: "Oops! Something went wrong while I was searching for jobs. Can you try again?"
                    ))
                    self.jobPills = []
                    self.isLoading = false
                    return
                }

                let jobs = parseJobs(jsonData: jsonData)

                if jobs.isEmpty {
                    self.messages.append(ChatMessage(
                        role: .assistant,
                        content: "Hmm, I couldn’t find any jobs matching your request. Maybe try tweaking the title or location?"
                    ))
                    self.jobPills = []
                } else {
                    self.messages.append(ChatMessage(
                        role: .assistant,
                        content: "Awesome! I found some openings on Adzuna that match what you're looking for:"
                    ))

                    let pills = jobs.prefix(5).map { job in
                        JobPillViewModel(
                            title: job.title,
                            location: job.location.displayName,
                            company: "Adzuna"
                        )
                    }

                    self.jobPills = pills
                }

                self.isLoading = false
            }
        }
    }
}

