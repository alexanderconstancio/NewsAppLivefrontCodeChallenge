//
//  LivefrontCodeChallengeUITests.swift
//  LivefrontCodeChallengeUITests
//
//  Created by Alex Constancio on 9/30/21.
//

import XCTest
@testable import LivefrontCodeChallenge

class LivefrontCodeChallengeUITests: XCTestCase {
    // Testing articleViewModel against the article object
    func testUIActions() {
        let app = XCUIApplication()
        let collectionViewsQuery = app.collectionViews
        XCTAssertTrue(collectionViewsQuery
                        .buttons["dropdown arrow"]
                        .exists)
        XCTAssertTrue(collectionViewsQuery
                        .cells
                        .containing(
                            .staticText, identifier:"News!")
                        .children(matching: .other)
                        .element(boundBy: 0)
                        .exists)
    }
}
