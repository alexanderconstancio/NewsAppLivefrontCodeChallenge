//
//  LivefrontCodeChallengeUITestsLaunchTests.swift
//  LivefrontCodeChallengeUITests
//
//  Created by Alex Constancio on 9/30/21.
//

import XCTest

class LivefrontCodeChallengeUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
