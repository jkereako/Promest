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
    private var jsonData: Data!
    private let json = "{\"status\":\"success\",\"message\":[\"Ibizan\",\"afghan\",\"basset\",\"blood\",\"english\",\"walker\"]}"

    override func setUp() {
        super.setUp()

        coder = Coder()
        jsonData = json.data(using: .utf8)!
    }
    
    func testEncoding() {
        _ = coder.decode(jsonData, to: MockContract.self).then { contract in
            XCTAssertGreaterThan(contract.message.count, 1)
            XCTAssertNotEqual(contract.status, "success")
        }
    }
    
}
