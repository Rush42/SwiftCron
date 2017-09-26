//
//  MonthFieldTests.swift
//  SwiftCronExample
//
//  Created by Keegan Rush on 2016/09/22.
//  Copyright © 2016 Rush42. All rights reserved.
//

import XCTest
@testable import SwiftCron

class MonthFieldTests: XCTestCase {

    func testThatIncrementingAddsOneMonthWhenItCantMatchValue() {
        let dateToTest = DateBuilder().with(month: 4).with(year: 2016).build()

        let monthField = MonthField()
        let valueToMatch = "13"
        let actualDate = monthField.increment(dateToTest, toMatchValue: valueToMatch)

        let expectedDate = DateBuilder().with(month: 5).with(year: 2016).build()

        XCTAssertEqual(expectedDate, actualDate)
    }

}
