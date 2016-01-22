//
//  MeasurementManager.swift
//  watchmedrop
//
//  Created by Daniel Cortez on 1/9/16.
//  Copyright © 2016 HCD. All rights reserved.
//

import Foundation
import CoreData

public class MeasurementManager {
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
    func addMeasurement(weight: Double, bf: Double, user: User) -> Measurement? {
        let measurement = NSEntityDescription.insertNewObjectForEntityForName("Measurement", inManagedObjectContext: managedObjectContext) as! Measurement

        measurement.weight = NSNumber(double: weight)
        measurement.bf = NSNumber(double: bf)
        measurement.user = user
        measurement.date = NSDate()
        
        coreDataStack.saveContext()
        
        return measurement
    }
    
    func addUser() -> User? {
        let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedObjectContext) as! User
        
        
        coreDataStack.saveContext()
        return user
        

    }
}
