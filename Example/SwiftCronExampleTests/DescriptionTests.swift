//
//  DescriptionTests.swift
//  SwiftCronExample
//
//  Created by Keegan Rush on 2016/05/10.
//  Copyright © 2016 Rush42. All rights reserved.
//

import XCTest
import SwiftCron

class DescriptionTests: XCTestCase {

	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}

	// * * * * * *
	func testDescriptionOfEveryMinute() {
		let cronExpression = CronExpression(minute: "*")!

		let description = cronExpression.shortDescription
		let expectedDescription = "Every minute"
		XCTAssertEqual(description, expectedDescription)

		let longDescription = cronExpression.longDescription
		XCTAssertEqual(longDescription, expectedDescription)
	}

//    func testDescriptionOfEveryMinuteIn2017() {
//        let cronExpression = CronExpression(cronString: "* * * * * 2017")!
//        
//        let description = cronExpression.shortDescription
//        let expectedDescription = "Every minute"
//        XCTAssertEqual(description, expectedDescription)
//        
//        let longDescription = cronExpression.longDescription
//        XCTAssertEqual(longDescription, expectedDescription)
//    }
//
//    func testDescriptionOfEveryMinuteIn2017a() {
//        let cronExpression = CronExpression(cronString: "* 2 * * * 2017")!
//        
//        let description = cronExpression.shortDescription
//        let expectedDescription = "Every minute"
//        XCTAssertEqual(description, expectedDescription)
//        
//        let longDescription = cronExpression.longDescription
//        XCTAssertEqual(longDescription, expectedDescription)
//    }
//    
//    func testDescriptionOfEveryMinuteIn2017b() {
//        let cronExpression = CronExpression(cronString: "2 * * * * 2017")!
//        
//        let description = cronExpression.shortDescription
//        let expectedDescription = "Every minute"
//        XCTAssertEqual(description, expectedDescription)
//        
//        let longDescription = cronExpression.longDescription
//        XCTAssertEqual(longDescription, expectedDescription)
//    }

	// 0 12 * * * *
	func testDescriptionOfEveryDayAtMidday() {
		let cronExpression = CronExpression(minute: "0", hour: "12")!

		let description = cronExpression.shortDescription
		let expectedDescription = "Every day"
		XCTAssertEqual(description, expectedDescription)

		let longDescription = cronExpression.longDescription
		let expectedLongDescription = "Every day at 12:00"
		XCTAssertEqual(longDescription, expectedLongDescription)
	}

	// 0 0 14 * * *
	func testDescriptionOfEveryMonthOn14th() {
		let cronExpression = CronExpression(minute: "0", hour: "0", day: "14")!

		let description = cronExpression.shortDescription
		let expectedDescription = "Every 14th of the month"
		XCTAssertEqual(description, expectedDescription)

		let longDesc = cronExpression.longDescription
		let expectedLongDesc = "Every 14th of the month at 00:00"
		XCTAssertEqual(longDesc, expectedLongDesc)
	}

	// 0 0 14 2 * *
	func testDescriptionOfEveryYearFeb14th() {
		let cronExpression = CronExpression(minute: "0", hour: "0", day: "14", month: "2")!

		let description = cronExpression.shortDescription
		let expectedDescription = "Every 14th of February"
		XCTAssertEqual(description, expectedDescription)

		let longDesc = cronExpression.longDescription
		let expectedLongDesc = "Every 14th of February at 00:00"
		XCTAssertEqual(longDesc, expectedLongDesc)
	}

	// 0 0 13 * 6 *
	func testDescriptionOfEveryFriday13th() {
		let cronExpression = CronExpression(minute: "0", hour: "0", day: "13", weekday: "5")!

		let description = cronExpression.shortDescription
		let expectedDescription = "Every Friday the 13th"
		XCTAssertEqual(description, expectedDescription)

		let longDesc = cronExpression.longDescription
		let expectedLongDesc = "Every Friday the 13th at 00:00"
		XCTAssertEqual(longDesc, expectedLongDesc)
	}

	// 0 0 * * 2,3,4,5,6 *
	func testDescriptionOfWeekdays() {
		let cronExpression = CronExpression(minute: "0", hour: "0", weekday: "1,2,3,4,5")!

		let description = cronExpression.shortDescription
		let expectedDescription = "Every weekday"
		XCTAssertEqual(description, expectedDescription)

		let longDesc = cronExpression.longDescription
		let expectedLongDesc = "Every weekday at 00:00"
		XCTAssertEqual(longDesc, expectedLongDesc)
	}

	// 0 12 * * 1,7 *
	func testDescriptionOfWeekend() {
		let cronExpression = CronExpression(minute: "0", hour: "12", weekday: "6,7")!

		let description = cronExpression.shortDescription
		let expectedDescription = "Every Saturday, Sunday"
		XCTAssertEqual(description, expectedDescription)

		let longDesc = cronExpression.longDescription
		let expectedLongDesc = "Every Saturday, Sunday at 12:00"
		XCTAssertEqual(longDesc, expectedLongDesc)
	}

	// * * * * 2 *
	func testDescriptionOfOnlyWeekdaySpecified() {
		let cronExpression = CronExpression(weekday: "1")!

		let description = cronExpression.shortDescription
		let expectedDescription = "Every minute on a Monday"
		XCTAssertEqual(description, expectedDescription)

		let longDesc = cronExpression.longDescription
		XCTAssertEqual(longDesc, expectedDescription)
	}

	// 0 0 11 5 * 2026
	func testDescriptionOfMay112016() {
		let cronExpression = CronExpression(minute: "0", hour: "0", day: "11", month: "5", year: "2026")!

		let description = cronExpression.shortDescription
		let expectedDescription = "11th of May 2026"
		XCTAssertEqual(description, expectedDescription)

		let longDesc = cronExpression.longDescription
		let expectedLongDesc = "11th of May 2026 at 00:00"
		XCTAssertEqual(longDesc, expectedLongDesc)
	}

	// 0 0 * * 1,3 *
	func testDescriptionOfMondayAndWednesday() {
		let cronExpression = CronExpression(minute: "0", hour: "0", weekday: "1,3")!

		let description = cronExpression.shortDescription
		let expectedDescription = "Every Monday, Wednesday"
		XCTAssertEqual(description, expectedDescription)

		let longDesc = cronExpression.longDescription
		let expectedLongDesc = "Every Monday, Wednesday at 00:00"
		XCTAssertEqual(longDesc, expectedLongDesc)
	}

	// 30 * 11 * * *
	func testEveryHourAt30MinutesOn11thOfTheMonth() {
		let cronExpression = CronExpression(minute: "30", day: "11")!

		let description = cronExpression.shortDescription
		let expectedDescription = "Every hour at 30 minutes on the 11th"
		XCTAssertEqual(description, expectedDescription)

		let longDesc = cronExpression.longDescription
		XCTAssertEqual(longDesc, expectedDescription)
	}

    func testEveryWeekdayAtEvery30MinutesOnATuesday() {
        let cronExpression = CronExpression(minute: "30", weekday:"2")!

        let description = cronExpression.shortDescription
        let expectedDescription = "Every 30 minutes on a Tuesday"
        XCTAssertEqual(description, expectedDescription)

        let longDesc = cronExpression.longDescription
        XCTAssertEqual(longDesc, expectedDescription)
    }

	// TODO: test all the crazy possible steps permutations

}
