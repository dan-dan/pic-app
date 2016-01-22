//
//  UserTests.swift
//  watchmedrop
//
//  Created by Daniel Cortez on 1/21/16.
//  Copyright © 2016 HCD. All rights reserved.
//

import XCTest
import CoreData
@testable import watchmedrop


class UserTests: XCTestCase {
    
    var coreDataStack : CoreDataStack!
    var manager : MeasurementManager!

    override func setUp() {
        super.setUp()
        
        
        coreDataStack = TestCoreDataStack()
        manager = MeasurementManager(managedObjectContext: coreDataStack.context, coreDataStack: coreDataStack)

    }
    
    override func tearDown() {
        
        super.tearDown()
        
        coreDataStack = nil
        manager = nil

    }
    
    func testAddUser() {
        
        let user = manager.addUser()
        XCTAssertNotNil(user, "User should not be nil")
        
    }
    
    func testRootContextIsSaved() {
        
        expectationForNotification(NSManagedObjectContextDidSaveNotification, object: coreDataStack.context) { notification in
                        return true
            
        }
        
        let _ = manager.addUser()

        waitForExpectationsWithTimeout(2.0) { error in
            XCTAssertNil( error, "Save did not occur")
            
        }
        
    }
    
    
}
