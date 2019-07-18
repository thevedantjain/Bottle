//
//  User+CoreDataProperties.swift
//  Bottle 2
//
//  Created by Vedant Jain on 16/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: Int16
    @NSManaged public var username: String?
    @NSManaged public var createdAt: String?
    @NSManaged public var updatedAt: String?
    @NSManaged public var workspaces: NSSet?
    @NSManaged public var projects: NSSet?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for workspaces
extension User {

    @objc(addWorkspacesObject:)
    @NSManaged public func addToWorkspaces(_ value: Workspace)

    @objc(removeWorkspacesObject:)
    @NSManaged public func removeFromWorkspaces(_ value: Workspace)

    @objc(addWorkspaces:)
    @NSManaged public func addToWorkspaces(_ values: NSSet)

    @objc(removeWorkspaces:)
    @NSManaged public func removeFromWorkspaces(_ values: NSSet)

}

// MARK: Generated accessors for projects
extension User {

    @objc(addProjectsObject:)
    @NSManaged public func addToProjects(_ value: Project)

    @objc(removeProjectsObject:)
    @NSManaged public func removeFromProjects(_ value: Project)

    @objc(addProjects:)
    @NSManaged public func addToProjects(_ values: NSSet)

    @objc(removeProjects:)
    @NSManaged public func removeFromProjects(_ values: NSSet)

}

// MARK: Generated accessors for tasks
extension User {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
