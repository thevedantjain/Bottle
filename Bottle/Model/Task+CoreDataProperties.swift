//
//  Task+CoreDataProperties.swift
//  Bottle 2
//
//  Created by Vedant Jain on 16/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var createdBy: Int16
    @NSManaged public var updatedAt: String?
    @NSManaged public var details: String?
    @NSManaged public var isComplete: Int16
    @NSManaged public var assignedTo: Int16
    @NSManaged public var project: Int16
    @NSManaged public var workspace: Int16
    @NSManaged public var createdAt: String?
    @NSManaged public var user: User?
    @NSManaged public var proj: Project?
    @NSManaged public var worksp: Workspace?

}
