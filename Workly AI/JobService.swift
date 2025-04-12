//
//  JobService.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-04-11.
//

// JobService.swift

import Foundation

class JobService {
    static let shared = JobService()

    func getJobDataFromWitAI(userQuery: String) -> Data? {
        let semaphore = DispatchSemaphore(value: 0)
        var jobData: Data? = nil

        let encodedQuery = userQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let witToken = "Bearer UBS724PZU4K6GCSLTAHUA624SBYB6PRT"

        let witURL = URL(string: "https://api.wit.ai/message?v=20240411&q=\(encodedQuery)")!
        var witRequest = URLRequest(url: witURL)
        witRequest.httpMethod = "GET"
        witRequest.setValue(witToken, forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: witRequest) { data, _, error in
            guard let data = data, error == nil else {
                print("Wit.ai error: \(error?.localizedDescription ?? "Unknown error")")
                semaphore.signal()
                return
            }

            do {
                let witResult = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let entities = witResult?["entities"] as? [String: Any]

                let jobTitle = (entities?["job_title:job_title"] as? [[String: Any]])?.first?["value"] as? String ?? "developer"
                let location = (entities?["location:location"] as? [[String: Any]])?.first?["value"] as? String ?? "USA"

                print("Parsed from Wit: \(jobTitle), \(location)")

                let appId = "9535593c"
                let appKey = "f2aed4b68604d38d366a4c39f1ec1e1c"
                let adzunaUrl = "https://api.adzuna.com/v1/api/jobs/us/search/1?app_id=\(appId)&app_key=\(appKey)&results_per_page=10&what=\(jobTitle)&where=\(location)"

                guard let url = URL(string: adzunaUrl) else {
                    print("Invalid Adzuna URL")
                    semaphore.signal()
                    return
                }

                let adzunaTask = URLSession.shared.dataTask(with: url) { adzunaData, _, adzunaError in
                    if let adzunaData = adzunaData {
                        jobData = adzunaData
                    } else {
                        print("Adzuna error: \(adzunaError?.localizedDescription ?? "Unknown error")")
                    }
                    semaphore.signal()
                }
                adzunaTask.resume()
            } catch {
                print("Failed to parse Wit.ai response: \(error)")
                semaphore.signal()
            }
        }

        task.resume()
        semaphore.wait()
        return jobData
    }
}
