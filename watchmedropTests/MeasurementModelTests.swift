//
//  MeasurementModel.swift
//  watchmedrop
//
//  Created by Daniel Cortez on 1/9/16.
//  Copyright © 2016 HCD. All rights reserved.
//

import XCTest
import CoreData
@testable import watchmedrop



class MeasurementModelTests: XCTestCase {
    
    var coreDataStack : CoreDataStack!
    var manager : MeasurementManager!
    var testUser : User!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        coreDataStack = TestCoreDataStack()
        manager = MeasurementManager(managedObjectContext: coreDataStack.context, coreDataStack: coreDataStack)
        testUser = manager.addUser()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        coreDataStack = nil
        manager = nil
        testUser = nil
    }
    
    
    func testAddMeasurement() {
        
        let measurement = manager.addMeasurement(145, bf: 0.20, user: testUser)
        XCTAssertNotNil(measurement, "User should not be nil")

    }
    
    
    func testRootContextIsSaved() {
        
        expectationForNotification(NSManagedObjectContextDidSaveNotification, object: coreDataStack.context) { notification in
            return true
            
        }
        
        let _ = manager.addMeasurement(145, bf: 0.20, user: testUser)

        waitForExpectationsWithTimeout(2.0) { error in
            XCTAssertNil( error, "Save did not occur")
            
        }
        
    }

    func testWeightCorrect() {
        
        
    }
    
    func testBFCorrect() {
        
        
    }
    
    func testUserCorrect() {
        
    }
    
    func testDateNotNil() {
        
    }
    
    func testRandomMeasurmentCount() {
        
        
    
    }
    

}
