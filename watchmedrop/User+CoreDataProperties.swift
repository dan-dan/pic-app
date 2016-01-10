//
//  User+CoreDataProperties.swift
//  watchmedrop
//
//  Created by Daniel Cortez on 1/9/16.
//  Copyright © 2016 HCD. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var measurements: NSOrderedSet?

}
