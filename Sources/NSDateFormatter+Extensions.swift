//
//  NSDateFormatter+Extensions.swift
//  Pods
//
//  Created by Keegan Rush on 2016/05/12.
//
//

import Foundation

extension DateFormatter {
	private static let timeDateFormatter: DateFormatter = {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "HH:mm"
			return dateFormatter
	}()

	private static let minuteDateFormatter: DateFormatter = {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "mm"
			return dateFormatter
	}()

	private static let weekdayFormatter: DateFormatter = {
			let formatter = DateFormatter()
			formatter.dateFormat = "EEEE"
			return formatter
	}()

	static func timeStringWithHour(_ hour: String, minute: String) -> String {
		let theHour = Int(hour)
		let theMinute = Int(minute)
//		assert(theMinute < 60 && theMinute > -1)
//		assert(theHour > -1 && theHour < 25)

		let calendar = Calendar.current
		var components = DateComponents()
		components.hour = theHour
		components.minute = theMinute
		let date = calendar.date(from: components)!
		return timeDateFormatter.string(from: date)
	}

	static func minuteStringWithMinute(_ minute: String) -> String {
		let theMinute = Int(minute)!
		assert(theMinute < 60 && theMinute > -1)

		let calendar = Calendar.current
		var components = DateComponents()
		components.minute = theMinute
		let date = calendar.date(from: components)!
		return minuteDateFormatter.string(from: date)
	}

	static func convertStringToDaysOfWeek(_ weekdaysString: String) -> String {

		var daysOfWeekArray: Array<String> = []
		let days = weekdaysString.components(separatedBy: CronRepresentation.ListIdentifier)

		let calendar = Calendar.current
		let searchDate = Date(timeIntervalSince1970: 0)
		var components = DateComponents()

		for day in days {
			// Currently arranged from 1-7 starting at Sunday. Rearrange to 1-7 starting at Monday.
			let dayNumber = Date.convertWeekdayWithMondayFirstToSundayFirst(Int(day)!)

			assert(dayNumber >= 1 && dayNumber <= 7, "Day does not fit in week")
			components.weekday = dayNumber
            let date = calendar.nextDate(after: searchDate, matching: components, matchingPolicy: .strict)!
			let dayString = DateFormatter.weekdayFormatter.string(from: date)
			if days.contains(dayString) == false {
				daysOfWeekArray.append(dayString)
			}
		}

		// Sunday will be first. Make it last
		let sunday = "Sunday"
		if daysOfWeekArray.contains(sunday) {
			daysOfWeekArray.remove(at: daysOfWeekArray.index(of: sunday)!)
			daysOfWeekArray.append(sunday)
		}

		return daysOfWeekArray.joined(separator: ", ")
	}
}
