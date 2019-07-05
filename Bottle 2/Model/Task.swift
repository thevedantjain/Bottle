//
//  Tasks.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import Foundation

struct Task: Decodable {
    let id: Int?
    let title: String?
    let createdBy: Int?
    let createdAt: String?
    let updatedAt: String?
    let details: String?
    let isComplete: Int?
    let assignedTo: Int?
    let project: Int?
    let workspace: Int?
}

struct TaskResponse: Decodable {
    let tasks: [Task]?
}
