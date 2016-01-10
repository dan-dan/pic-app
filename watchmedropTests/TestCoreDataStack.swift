//
//  TestCoreDataStack.swift
//  watchmedrop
//
//  Created by Daniel Cortez on 1/9/16.
//  Copyright © 2016 HCD. All rights reserved.
//

@testable import watchmedrop
import Foundation
import CoreData


class TestCoreDataStack : CoreDataStack {
    
    override init() {
        super.init()
        
        self.persistentStoreCoordinator = {
            
            let psc = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
            
            do {
                try psc.addPersistentStoreWithType(NSInMemoryStoreType, configuration: nil, URL: nil, options: nil)
            } catch {
                fatalError()
            }
           return psc
        }()
    }
    
    
}