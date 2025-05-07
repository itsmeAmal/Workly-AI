import Foundation

struct Job: Identifiable, Decodable {
    let id: String
    let title: String
    //let location: DisplayNameEntity
    let location: String
    let description: String
    let redirectUrl: String
    //let company: DisplayNameEntity
    let company: String
    let salaryMin: Double?
    let salaryMax: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case description
        case redirectUrl = "redirect_url"
        case company
        case salaryMin = "salary_min"
        case salaryMax = "salary_max"
    }
}

