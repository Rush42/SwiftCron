//
//  SwiftCronTests.swift
//  SwiftCronTests
//
//  Created by Keegan Rush on 2016/05/05.
//  Copyright © 2016 Rush42. All rights reserved.
//

import XCTest
import SwiftCron

class SwiftCronTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	func testGetCronWithValidExpression() {
		let cron = CronExpression(cronString: "1 * * * * *")
		XCTAssertNotNil(cron)
	}

	func testGetCronWithInvalidExpression() {
		let cron = CronExpression(cronString: "foo")
		XCTAssertNil(cron)
	}

	func testPerformance() {
		measure({
			let cron = CronExpression(cronString: "32 4 8 12 3 *")
			var runDate: Date?

			runDate = cron?.getNextRunDate(TestData.jan1_2017)
			XCTAssertNotNil(runDate)
		})

	}

}
