//
//  Post.swift
//  subReddit
//
//  Created by Mnumzana Franklin Moyo on 12/28/24.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: String
    let body: String
    let userId: String?
    let subredditId: String?
    let createdAt: String
    let updatedAt: String
    let v: Int?
    let score: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case body
        case userId
        case subredditId
        case createdAt
        case updatedAt
        case v = "__v"
        case score
    }
}
