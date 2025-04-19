//
//  WitAIService.swift
//  Workly AI
//
//  Created by Amal Wickramarathna on 2025-04-09.
//

//import Foundation
//
//class WitAIService {
//    private let token = "Bearer UBS724PZU4K6GCSLTAHUA624SBYB6PRT"
//    private let session = URLSession.shared
//    private let baseURL = "https://api.wit.ai/message?v=20230204&q="
//    
//    func sendMessageToWitAI(message: String, completion: @escaping ([String: Any]?) -> Void) {
//        guard let url = URL(string: "\(baseURL)\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
//            completion(nil)
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue(token, forHTTPHeaderField: "Authorization")
//        
//        session.dataTask(with: request) { data, response, error in
//            guard let data = data,
//                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//                completion(nil)
//                return
//            }
//            completion(json)
//        }.resume()
//    }
//}

// WitAIService.swift
import Foundation

class WitAIService {
    private let witToken = "Bearer UBS724PZU4K6GCSLTAHUA624SBYB6PRT"

    func processMessage(_ message: String, completion: @escaping (WitResponse?) -> Void) {
        guard let url = URL(string: "https://api.wit.ai/message?v=20240401&q=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") else {
            completion(nil)
            return
        }

        var request = URLRequest(url: url)
        request.setValue(witToken, forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                let decoded = try JSONDecoder().decode(WitResponse.self, from: data)
                completion(decoded)
                print("=========================================================")
                print("Wit.ai response: \(decoded)")

            } catch {
                print("Decoding error:", error)
                completion(nil)
            }
        }.resume()
    }
}
