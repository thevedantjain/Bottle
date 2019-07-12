//
//  User.swift
//  Bottle 2
//
//  Created by Vedant Jain on 09/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import Foundation

// struct returned by api:users
struct User: Codable {
    var id: Int?
    var username: String?
    var createdAt: String?
    var updatedAt: String?
}

struct UserResponse: Codable {
    var users: [User]?
}

// struct returned by api:workspaceusers
struct WorkspaceUser: Codable {
    var userId: Int?
    var workspaceId: Int?
}

struct WorkspaceUserResponse: Codable {
    var users: [WorkspaceUser]?
}
