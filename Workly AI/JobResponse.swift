import SwiftUI

struct JobResponse: Decodable {
    let count: Int
    let results: [JobData]
}

struct JobData: Decodable {
    let id: String
    let title: String
    //let company: DisplayNameEntity
    //let location: DisplayNameEntity
    let company: String
    let location: String
    let salary_min: Double?
    let salary_max: Double?
    let description: String
    let redirect_url: String
}

func parseJobs(jsonData: Data) -> [Job] {
    let decoder = JSONDecoder()
    do {
        let jobResponse = try decoder.decode(JobResponse.self, from: jsonData)
        return jobResponse.results.map { job in
            Job(
                id: job.id,
                title: job.title,
                location: job.location,       // Correct order
                description: job.description, // Correct order
                redirectUrl: job.redirect_url,
                company: job.company,         // Correct order
                salaryMin: job.salary_min,
                salaryMax: job.salary_max
            )
        }
    } catch {
        print("Error parsing jobs: \(error)")
        return []
    }
}


