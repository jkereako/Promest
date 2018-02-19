//
//  CoderTests.swift
//  PromestTests
//
//  Created by Jeff Kereakoglow on 2/18/18.
//  Copyright © 2018 Alexis Digital. All rights reserved.
//

import XCTest
import Promises
@testable import Networking

final class CoderTests: XCTestCase {
    private var coder: CoderType!
    private let jsonFileLoader = JSONFileLoader(fileName: "dogs.json")

    override func setUp() {
        super.setUp()

        coder = Coder()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEncoding() {

        let jsonData = jsonFileLoader.load()
        let mockContract = coder.decode(jsonData, to: MockContract.self).then { contract in
            XCTAssertGreaterThan(contract.message.count, 1)
            XCTAssertEqual(contract.status, "success")
        }

        let predicate = NSPredicate(format: "success == true")
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: mockContract)

        let result = wait(for: [expectation], timeout: 1)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
