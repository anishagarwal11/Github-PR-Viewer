//
//  ProductModel.swift
//  practice45
//
//  Created by Anish Agarwal on 05/11/22.
//

import Foundation

// MARK: - GitHubElement

struct ClosedPRElement: Codable {
    var state: String? = ""
    var title: String? = ""
    var user: User?
    var createdAt: String? = ""
    var closedAt: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case state,title, user
        case createdAt = "created_at"
        case closedAt = "closed_at"
    }
    
//    init() {
//        state = ""
//        title = ""
//        user = nil
//        createdAt = ""
//        closedAt = ""
//    }
}

// MARK: - User
struct User: Codable {
    var login: String
    var avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarURL = "avatar_url"
    }
}

