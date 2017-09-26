//
//  MonthTests.swift
//  SwiftCron
//
//  Created by Keegan Rush on 2016/05/06.
//  Copyright © 2016 Rush42. All rights reserved.
//

import XCTest
import SwiftCron

class MonthTests: XCTestCase {

	func testEveryMonthOn1stRunsNextMonth() {
		let calendar = Calendar.current

		let dateToTestFrom = TestData.may11

		let firstDayOfMonthCron = CronExpression(minute: "0", hour: "0", day: "1")
		let nextRunDate = firstDayOfMonthCron?.getNextRunDate(dateToTestFrom)

		XCTAssertTrue(calendar.isDate(TestData.june1, inSameDayAs: nextRunDate!))
	}

}
