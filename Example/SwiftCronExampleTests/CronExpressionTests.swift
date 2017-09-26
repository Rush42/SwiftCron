//
//  CronExpressionTests.swift
//  SwiftCronExample
//
//  Created by Keegan Rush on 2016/11/09.
//  Copyright © 2016 Rush42. All rights reserved.
//

import Foundation
import XCTest

@testable import SwiftCron

class CronExpressionTests: XCTestCase {

    func testCreatingCronExpressionWithInvalidValueReturnsNil() {
        let invalidDay = "!@# $%^"
        let cronExpression = CronExpression(minute: "4", hour: "3", day: invalidDay, month: "1", weekday: "2", year: "2016")

        XCTAssertNil(cronExpression)
    }

    func testCronStringIsCorrect() {
        let cronString = "1 2 3 4 5 6"
        let cronExpression = CronExpression(cronString: cronString)!

        XCTAssertEqual(cronExpression.stringRepresentation, cronString)
    }
}
