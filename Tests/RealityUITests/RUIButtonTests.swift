//
//  RUIButtonTests.swift
//  
//
//  Created by Max Cobb on 25/01/2023.
//

import XCTest
@testable import RealityUI

final class RUIButtonTests: XCTestCase {

    var button: RUIButton!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        button = RUIButton()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDefaultInitialization() {
        XCTAssertNotNil(button)
    }

    func testTouchUpCompletedCallback() {
        let expectation = self.expectation(description: "touchUpInside callback was called")
        button.touchUpInside = { _ in
            expectation.fulfill()
        }
        button.arTouchStarted(at: SIMD3<Float>(0, 0, 0), hasCollided: true)
        button.arTouchEnded(at: nil, hasCollided: nil)
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testTouchUpCompletedNotCalled() {
        let expectation = self.expectation(description: "touchUpInside callback was not called")
        expectation.isInverted = true
        button.touchUpInside = { _ in
            expectation.fulfill()
        }
        button.arTouchEnded(at: nil, hasCollided: nil)
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testTouchUpCompletedNotCalledTouchMoved() {
        let expectation = self.expectation(description: "touchUpInside callback was not called")
        expectation.isInverted = true
        button.touchUpInside = { _ in
            expectation.fulfill()
        }
        button.arTouchStarted(at: SIMD3<Float>(0, 0, 0), hasCollided: true)
        button.arTouchUpdated(at: SIMD3<Float>(5, 5, 0), hasCollided: false)
        button.arTouchEnded(at: nil, hasCollided: nil)
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testCompressButton() {
        button.arTouchStarted(at: SIMD3<Float>(0, 0, 0), hasCollided: true)
        XCTAssertTrue(button.button.isCompressed)
        button.arTouchStarted(at: SIMD3<Float>(0, 0, 0), hasCollided: true)
    }

    func testCancelReleaseButton() {
        let expectation = self.expectation(description: "touchUpInside callback was not called")
        expectation.isInverted = true
        button.touchUpInside = { _ in expectation.fulfill() }
        button.arTouchStarted(at: SIMD3<Float>(0, 0, 0), hasCollided: true)
        button.arTouchCancelled()
        waitForExpectations(timeout: 0.1, handler: nil)
    }

    func testChangeColour() {
        button.baseColor = .black
        button.buttonColor = .orange
        XCTAssertEqual(button.baseColor, .black)
        XCTAssertEqual(button.buttonColor, .orange)
    }
}
