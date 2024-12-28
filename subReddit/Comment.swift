//
//  Comment.swift
//  subReddit
//
//  Created by Mnumzana Franklin Moyo on 12/28/24.
//

import Foundation

struct Comment: Codable, Identifiable {
    let id: Int
    let body: String
    let createdAt: String
    let userId: Int
    let postId: Int
}
