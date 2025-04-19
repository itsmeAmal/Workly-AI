//
//  ChatBotViewModel.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-04-19.
//

import Foundation
import SwiftUI

class ChatBotViewModel: ObservableObject {
    @Published var userInput = ""
    @Published var messages: [ChatMessage] = []
    @Published var isLoading = false
    @Published var jobPills: [JobPillViewModel] = []

    func sendMessage() {
        let input = userInput.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !input.isEmpty else { return }

        messages.append(ChatMessage(role: .user, content: input))
        userInput = ""
        isLoading = true

        DispatchQueue.global(qos: .userInitiated).async {
            if let data = JobService.shared.getJobDataFromWitAI(userQuery: input) {
                let jobs = parseJobs(jsonData: data)

                DispatchQueue.main.async {
                    if jobs.isEmpty {
                        self.messages.append(ChatMessage(role: .assistant, content: "Hmm, I couldn’t find any jobs matching that search. Maybe try changing your job title or location?"))
                    } else {
                        self.messages.append(ChatMessage(role: .assistant, content: "Great news! 🎉 I found some job openings on Adzuna. Here are a few you might be interested in:"))

                        let pills = jobs.prefix(5).map { job in
                            JobPillViewModel(
                                title: job.title,
                                location: job.location.displayName,
                                company: "Adzuna"
                            )
                        }
                        self.jobPills = pills
                        
//                        print("==========================================================================")
//                        print("User asked: \(self.userInput)")
//                        print("Parsed Jobs: \(jobs.map { $0.title + " - " + $0.location.displayName })")

                    }

                    self.isLoading = false
                }
            } else {
                DispatchQueue.main.async {
                    self.messages.append(ChatMessage(role: .assistant, content: "Oops! Something went wrong while fetching jobs."))
                    self.isLoading = false
                }
            }
        }
    }
}
