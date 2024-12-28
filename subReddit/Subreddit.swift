//
//  Subreddit.swift
//  subReddit
//
//  Created by Mnumzana Franklin Moyo on 12/28/24.
//

import Foundation

struct Subreddit: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String
}
