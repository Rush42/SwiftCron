//
//  NSDate+Extensions.swift
//  Pods
//
//  Created by Keegan Rush on 2016/05/25.
//
//

import Foundation
extension Date {
	static func convertWeekdayWithMondayFirstToSundayFirst(_ weekday: Int) -> Int {
		let sundayWhenFirstDayOfWeek = 1
		let sundayWhenMondayFirst = 7

		// Currently arranged from 1-7 starting at Sunday. Rearrange to 1-7 starting at Monday.
		if weekday == sundayWhenMondayFirst {
			return sundayWhenFirstDayOfWeek
		}
		return weekday + 1
	}

	func nextDate(matchingUnit unit: NSCalendar.Unit, value: String) -> Date? {
		let calendar = Calendar.current

		var valueToMatch: Int!

		if value.contains(CronRepresentation.ListIdentifier) {
			// TODO: issue 13: Match list items
			return nil
		} else {
			valueToMatch = Int(value)
		}

		guard valueToMatch != nil else {
			return nil
		}

		var components = DateComponents()

		switch unit {
		case NSCalendar.Unit.era:
			components.era = valueToMatch
		case NSCalendar.Unit.year:
			if calendar.component(.year, from: self) >= valueToMatch {
				return nil
			}
			components.year = valueToMatch
		case NSCalendar.Unit.month:
			components.month = valueToMatch
		case NSCalendar.Unit.day:
			components.day = valueToMatch
		case NSCalendar.Unit.hour:
			components.hour = valueToMatch
		case NSCalendar.Unit.minute:
			components.minute = valueToMatch
		case NSCalendar.Unit.second:
			components.second = valueToMatch
		case NSCalendar.Unit.weekday:
			components.weekday = valueToMatch
		case NSCalendar.Unit.weekdayOrdinal:
			components.weekdayOrdinal = valueToMatch
		case NSCalendar.Unit.quarter:
			components.quarter = valueToMatch
		case NSCalendar.Unit.weekOfMonth:
			components.weekOfMonth = valueToMatch
		case NSCalendar.Unit.weekOfYear:
			components.weekOfYear = valueToMatch
		case NSCalendar.Unit.yearForWeekOfYear:
			components.yearForWeekOfYear = valueToMatch
		case NSCalendar.Unit.nanosecond:
			components.nanosecond = valueToMatch
		default:
			print("\(#function): Not a valid calendar unit for this function.")
			return nil
		}

        return calendar.nextDate(after: self, matching: components, matchingPolicy: .strict)
	}

    func getLastDayOfMonth() -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month], from: self)

        switch components.month! {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        case 2:
            let range = calendar.range(of: .day, in: .month, for: calendar.date(from: components)!)!
            return range.upperBound - range.lowerBound
        default:
            return 30
        }
    }

}
