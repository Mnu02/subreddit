//
//  APIClient.swift
//  subReddit
//
//  Created by Mnumzana Franklin Moyo on 12/28/24.
//

import Foundation
import FirebaseAuth

class APIClient {
    static let shared = APIClient()
    private init () {}
    
    // MARK: Base URL
    private let baseURL = URL(string: "http://localhost:4000/api")!
    
    
    // MARK: Fetch Posts
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        let endpoint = baseURL.appendingPathComponent("posts")
        var request = URLRequest(url: endpoint)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    // MARK: Create Post
    func createPost(body: String, userId: String, subredditId: String, completion: @escaping(Result<Post, Error>) -> Void) {
        let endpoint = baseURL.appendingPathComponent("posts")
        var request = URLRequest(url: endpoint)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "body": body,
            "userId": userId,
            "subredditId": subredditId
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            do {
                let post = try JSONDecoder().decode(Post.self, from: data)
                completion(.success(post))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    // MARK: Vote on Post
    func voteOnpost(postId: String, userId: String, value: Int, completion: @escaping (Result<Vote, Error>) -> Void) {
        let endpoint = baseURL.appendingPathComponent("votes")
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String : Any] = [
            "postId": postId,
            "userId": userId,
            "value": value
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0)))
                return
            }
            do {
                let vote = try JSONDecoder().decode(Vote.self, from: data)
                completion(.success(vote))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
