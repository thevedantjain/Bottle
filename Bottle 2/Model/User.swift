//
//  User.swift
//  Bottle 2
//
//  Created by Vedant Jain on 09/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import Foundation

// struct returned by api:users
struct User: Decodable {
    var id: Int?
    var username: String?
    var createdAt: String?
    var updatedAt: String?
}

struct UserResponse: Decodable {
    var users: [User]?
}

// struct returned by api:workspaceusers
struct WorkspaceUser: Decodable {
    var userId: Int?
    var workspaceId: Int?
}

struct WorkspaceUserResponse: Decodable {
    var users: [WorkspaceUser]?
}
