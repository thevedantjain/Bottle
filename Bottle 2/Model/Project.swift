//
//  Team.swift
//  Bottle 2
//
//  Created by Vedant Jain on 12/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//

import Foundation

struct Project: Decodable {
    var id: Int?
    var name: String?
    var createdBy: Int?
    var createdAt: String?
    var updatedAt: String?
    var workspace: Int?
}
