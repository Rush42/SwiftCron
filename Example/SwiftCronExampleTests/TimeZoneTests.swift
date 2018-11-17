import XCTest
import SwiftCron

class TimeZoneTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTimeZoneDifferencesResultInVariationOfNextRunDate() {
        let newYorkTZ = TimeZone(identifier: "America/New_York")!
        let losAngelesTZ = TimeZone(identifier: "America/Los_Angeles")!

        let cronExpression = CronExpression(cronString: "0 10 12 9 * *")!

        let nextRunNewYorkTZ = cronExpression.getNextRunDateFromNow(adjustingForTimeZone: newYorkTZ)!
        let nextRunLosAngelesTZ = cronExpression.getNextRunDateFromNow(adjustingForTimeZone: losAngelesTZ)!

        XCTAssertNotEqual(nextRunNewYorkTZ, nextRunLosAngelesTZ)
    }
}
