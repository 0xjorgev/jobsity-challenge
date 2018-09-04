//
//  CodeChallengeTests.swift
//  CodeChallengeTests
//
//  Created by Jorge Mendoza on 8/31/18.
//  Copyright © 2018 Jorge Mendoza. All rights reserved.
//

import XCTest
@testable import CodeChallenge

class CodeChallengeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
//        Services.shared.retriveShowList(page: 1){
//            (show, error) in
//
//            let first = show?.first
//            XCTAssertEqual(first?.id ?? 0, 123)
//            //XCTAssertTrue(1 != 1)
//
//        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testShowListService(){
        
        Services.shared.retriveShowList(page: 1){
            (show, error) in
            
            let first = show?.first
            XCTAssertTrue((first?.id ?? 0) == 250)
            //XCTAssertTrue(1 != 1)
            
        }
        
    }
    
    func testShowSearch(){
        
        Services.shared.searchShowByName(query: "girls"){
            (show, error) in
            
            let first = show?.first?.score
            //17.396406
            XCTAssertEqual(first ?? 0.0, 5.0)
            
        }
    }
    
    func testPeopleSearch(){
        
        Services.shared.peopleSearch(query: "lauren"){
            (show, error) in
            
            let first = show?.first?.score
            XCTAssertTrue((first ?? 0.0) == 34.579826)
            
        }
    }
    
}
