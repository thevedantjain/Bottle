//
//  Project+CoreDataProperties.swift
//  Bottle 2
//
//  Created by Vedant Jain on 16/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//
//

import Foundation
import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var createdBy: Int16
    @NSManaged public var updatedAt: String?
    @NSManaged public var workspace: Int16
    @NSManaged public var createdAt: String?
    @NSManaged public var worksp: Workspace?
    @NSManaged public var users: NSSet?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for users
extension Project {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: User)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: User)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}

// MARK: Generated accessors for tasks
extension Project {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
