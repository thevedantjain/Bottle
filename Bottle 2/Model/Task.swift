//
//  Tasks.swift
//  Bottle 2
//
//  Created by Vedant Jain on 06/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import Foundation

struct Task: Codable {
    var id: Int?
    var title: String?
    var createdBy: Int?
    var createdAt: String?
    var updatedAt: String?
    var details: String?
    var isComplete: Int?
    var assignedTo: Int?
    var project: Int?
    var workspace: Int?
}

struct TaskResponse: Codable {
    var tasks: [Task]?
}
