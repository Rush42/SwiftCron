//
//  MinuteTests.swift
//  SwiftCron
//
//  Created by Keegan Rush on 2016/05/06.
//  Copyright © 2016 Rush42. All rights reserved.
//

import XCTest
import SwiftCron

class MinuteTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testEvery30thMinute() {
		let calendar = Calendar.current

		let dateToTestFrom = TestData.may11

		var components = calendar.dateComponents([.day, .year, .month, .hour], from: dateToTestFrom)
		components.minute = 30
		let expectedDate = calendar.date(from: components)

		let every30thMinuteCron = CronExpression(minute: "30")
		let nextRunDate = every30thMinuteCron?.getNextRunDate(dateToTestFrom)

		XCTAssertTrue(calendar.isDate(nextRunDate!, equalTo: expectedDate!, toGranularity: .minute))
	}

    func testEvery15thAnd45thMinutes() {
        let dateToTestFrom = TestData.may11

        let every15thand45thMinuteCron = CronExpression(minute: "15,45")!

        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .year, .month, .hour, .minute], from: dateToTestFrom)
        components.minute! += 15
        let expectedNextRunDate = calendar.date(from: components)!
        var nextRunDate = every15thand45thMinuteCron.getNextRunDate(dateToTestFrom)!
        XCTAssertTrue(calendar.isDate(nextRunDate, equalTo: expectedNextRunDate, toGranularity: .minute))

        components.minute! += 30
        let expectedFollowingRunDate = calendar.date(from: components)!
        nextRunDate = every15thand45thMinuteCron.getNextRunDate(addMinuteTo(date: nextRunDate))!
        XCTAssertTrue(calendar.isDate(nextRunDate, equalTo: expectedFollowingRunDate, toGranularity: .minute))
    }

    func addMinuteTo(date: Date) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .year, .month, .hour, .minute], from: date)
        components.minute! += 1
        return calendar.date(from: components)!
    }

}
