//
//  Post.swift
//  subReddit
//
//  Created by Mnumzana Franklin Moyo on 12/28/24.
//

import Foundation

struct Post: Codable, Identifiable {
    let id: Int
    let body: String
    let createdAt: String
    let votes: Int
    let subredditId: Int
}
