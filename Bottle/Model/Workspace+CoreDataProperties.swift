//
//  Workspace+CoreDataProperties.swift
//  Bottle 2
//
//  Created by Vedant Jain on 16/07/19.
//  Copyright © 2019 Vedant Jain. All rights reserved.
//
//

import Foundation
import CoreData


extension Workspace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workspace> {
        return NSFetchRequest<Workspace>(entityName: "Workspace")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var createdBy: Int16
    @NSManaged public var createdAt: String?
    @NSManaged public var updatedAt: String?
    @NSManaged public var projects: NSSet?
    @NSManaged public var users: NSSet?

}

// MARK: Generated accessors for projects
extension Workspace {

    @objc(addProjectsObject:)
    @NSManaged public func addToProjects(_ value: Project)

    @objc(removeProjectsObject:)
    @NSManaged public func removeFromProjects(_ value: Project)

    @objc(addProjects:)
    @NSManaged public func addToProjects(_ values: NSSet)

    @objc(removeProjects:)
    @NSManaged public func removeFromProjects(_ values: NSSet)

}

// MARK: Generated accessors for users
extension Workspace {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: User)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: User)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}
