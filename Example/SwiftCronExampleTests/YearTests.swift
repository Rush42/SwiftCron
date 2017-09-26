//
//  YearTests.swift
//  SwiftCron
//
//  Created by Keegan Rush on 2016/05/06.
//  Copyright © 2016 Rush42. All rights reserved.
//

import XCTest
import SwiftCron

class YearTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testEveryYearOn1stJanRunsNextYear() {
		let calendar = Calendar.current

		let dateToTestFrom = TestData.may11

		let firstDayOfMonthCron = CronExpression(minute: "0", hour: "0", day: "1", month: "1")
		let nextRunDate = firstDayOfMonthCron?.getNextRunDate(dateToTestFrom)

		XCTAssertTrue(calendar.isDate(TestData.jan1_2017, inSameDayAs: nextRunDate!))
	}

    func testEveryThursdayIn2018RunsIn2018() {
        let thursdaysIn2018Cron = CronExpression(minute: "0", hour: "0", weekday: "4", year: "2018")!
        let dateToTestFrom = TestData.may15_2016
        let firstThursdayIn2018 = DateBuilder().with(day: 4).with(month: 1).with(year: 2018).build()
        let nextRunDate = thursdaysIn2018Cron.getNextRunDate(dateToTestFrom)!
        XCTAssertTrue(Calendar.current.isDate(firstThursdayIn2018, inSameDayAs: nextRunDate))
    }

    func testNextRunDateIsNilWhenDateIsInPast() {
        let dateToTestFrom = DateBuilder().with(month: 5).with(year: 2015).build()

        let firstDayOfFirstMonthInPastCron = CronExpression(minute: "0", hour: "0", day: "1", month: "1", year: "2014")
        let nextRunDate = firstDayOfFirstMonthInPastCron?.getNextRunDate(dateToTestFrom)

        XCTAssertNil(nextRunDate)
    }

    func testNextRunDateIsNilWhenDateIsNotInReasonableFuture() {
        let dateToTestFrom = DateBuilder().with(month: 5).with(year: 2015).build()

        let firstDayOfFirstMonthInPastCron = CronExpression(minute: "0", hour: "0", day: "1", month: "1", year: "999999")
        let nextRunDate = firstDayOfFirstMonthInPastCron?.getNextRunDate(dateToTestFrom)

        XCTAssertNil(nextRunDate)
    }

}
