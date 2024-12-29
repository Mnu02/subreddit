//
//  Vote.swift
//  subReddit
//
//  Created by Mnumzana Franklin Moyo on 12/28/24.
//

import Foundation

struct Vote: Codable {
    let id: String?
    let userId: String
    let postId: String
    let value: Int
}
