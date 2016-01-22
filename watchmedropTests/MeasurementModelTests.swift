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
    
    func testUserContainsMeasurement() {
        let measurement = manager.addMeasurement(145, bf: 0.20, user: testUser)
        let testValue = testUser.measurements?.firstObject as? Measurement
        
        XCTAssertNotNil(testValue, "Measurement should not be nil")
        XCTAssertEqual(testValue, measurement, "Measurement and test value are not equal")
    }

    func testWeightCorrect() {

        let testWeight = 145.8
        
        let _ = manager.addMeasurement(testWeight, bf: 0.28, user: testUser)
        let retrievedMeasurement = testUser.measurements?.firstObject as? Measurement
        XCTAssertEqual(retrievedMeasurement?.weight, NSNumber(double:testWeight), "Weights not equal")

    }
    
    func testBFCorrect() {
        
        let testBF = 0.28
        
        let _ = manager.addMeasurement(145, bf: testBF, user: testUser)
        let retrievedMeasurement = testUser.measurements?.firstObject as? Measurement
        XCTAssertEqual(retrievedMeasurement?.bf, NSNumber(double:testBF), "BF not equal")
    }
    
    
    func testDateNotNil() {
        
        let _ = manager.addMeasurement(145, bf: 0.20, user: testUser)
        let measurement = testUser.measurements?.firstObject as? Measurement
        XCTAssertNotNil(measurement?.date, "Measurement date should not be nil")
    }
    
    func testRandomMeasurmentCount() {
       
        let randomValue = Int(arc4random_uniform(UInt32(300))) // 300 max
        var i: Int

        for i = 0; i < randomValue; ++i {
        
            let testWeight =  Double(arc4random()) / 0xFFFFFFFF
            let testBF =  Double(arc4random()) / 0xFFFFFFFF
            let _ = manager.addMeasurement(testWeight, bf: testBF, user: testUser)

        }
        
        
        XCTAssertEqual(randomValue, testUser.measurements?.count, "Measurements are not equal")
    
    }
    

}
