//
//  CronDescriptionBuilder.swift
//  Pods
//
//  Created by Keegan Rush on 2016/05/10.
//
//

import Foundation

enum CronDescriptionLength { case short, long }

class CronDescriptionBuilder {
	static let EveryWeekday: String = {
			let cronExp = CronExpression(cronString: "0 0 * * 1,2,3,4,5 *")!
			return DateFormatter.convertStringToDaysOfWeek(cronExp.cronRepresentation.weekday)
	}()

	static let EveryDay: String = {
			let cronExp = CronExpression(cronString: "0 0 * * 1,2,3,4,5,6,7 *")!
			return DateFormatter.convertStringToDaysOfWeek(cronExp.cronRepresentation.weekday)
	}()

	static func buildDescription(_ cronRepresentation: CronRepresentation, length: CronDescriptionLength) -> String {
		if let biggestField = cronRepresentation.biggestField {
			switch biggestField {
			case .minute:
				return descriptionWithMinuteBiggest(cronRepresentation, length: length)
			case .hour:
				return descriptionWithHourBiggest(cronRepresentation, length: length)
			case .day:
				return descriptionWithDayBiggest(cronRepresentation, length: length)
			case .month:
				return descriptionWithMonthBiggest(cronRepresentation, length: length)
			case .weekday:
				break
			case .year:
				return descriptionWithYearBiggest(cronRepresentation, length: length)
			}
		}
		return descriptionWithNoneBiggest(cronRepresentation, length: length)
	}

	private static func descriptionWithNoneBiggest(_ cronRepresentation: CronRepresentation, length: CronDescriptionLength) -> String {
		if CronRepresentation.isDefault(cronRepresentation.weekday) {
			return "Every minute"
		} else {
			let weekday = DateFormatter.convertStringToDaysOfWeek(cronRepresentation.weekday)
			return "Every minute on a \(weekday)"
		}
	}

	private static func descriptionWithMinuteBiggest(_ cronRepresentation: CronRepresentation, length: CronDescriptionLength) -> String {
		let minutes = DateFormatter.minuteStringWithMinute(cronRepresentation.minute)
		if CronRepresentation.isDefault(cronRepresentation.weekday) {
			return "Every hour at \(minutes) minutes"
		} else {
			let weekday = DateFormatter.convertStringToDaysOfWeek(cronRepresentation.weekday)
			return "Every \(minutes) minutes on a \(weekday)"
		}
	}

	private static func descriptionWithHourBiggest(_ cronRepresentation: CronRepresentation, length: CronDescriptionLength) -> String {

		let time = DateFormatter.timeStringWithHour(cronRepresentation.hour, minute: cronRepresentation.minute)

		if CronRepresentation.isDefault(cronRepresentation.weekday) {
			switch length {
			case .long:
				return "Every day at \(time)"
			case .short:
				return "Every day"
			}
		} else {
			let weekday = DateFormatter.convertStringToDaysOfWeek(cronRepresentation.weekday)
			var desc: String
			if weekday == EveryDay {
				desc = "Every day"
			} else if weekday == EveryWeekday {
				desc = "Every weekday"
			} else {
				desc = "Every \(weekday)"
			}
			switch length {
			case .long:
				return "\(desc) at \(time)"
			case .short:
				return desc
			}
		}

	}

	private static func descriptionWithDayBiggest(_ cronRepresentation: CronRepresentation, length: CronDescriptionLength) -> String {
		let day = Int(cronRepresentation.day)!.ordinal

		if CronRepresentation.isDefault(cronRepresentation.hour) {
			let minutes = DateFormatter.minuteStringWithMinute(cronRepresentation.minute)
			return "Every hour at \(minutes) minutes on the \(day)"
		} else {
			let time = DateFormatter.timeStringWithHour(cronRepresentation.hour, minute: cronRepresentation.minute)
			if CronRepresentation.isDefault(cronRepresentation.weekday) {
				switch length {
				case .long:
					return "Every \(day) of the month at \(time)"
				case .short:
					return "Every \(day) of the month"
				}
			} else {
				let weekday = DateFormatter.convertStringToDaysOfWeek(cronRepresentation.weekday)
				switch length {
				case .long:
					return "Every \(weekday) the \(day) at \(time)"
				case .short:
					return "Every \(weekday) the \(day)"
				}
			}
		}
	}

	private static func descriptionWithMonthBiggest(_ cronRepresentation: CronRepresentation, length: CronDescriptionLength) -> String {
		let time = DateFormatter.timeStringWithHour(cronRepresentation.hour, minute: cronRepresentation.minute)
		let day = Int(cronRepresentation.day)!.ordinal
		let month = Int(cronRepresentation.month)!.convertToMonth()

		let desc = "Every \(day) of \(month)"
		if CronRepresentation.isDefault(cronRepresentation.weekday) {
			switch length {
			case .long:
				return "\(desc) at \(time)"
			case .short:
				return desc
			}
		} else {
			let weekday = DateFormatter.convertStringToDaysOfWeek(cronRepresentation.weekday)
			switch length {
			case .short:
				return "Every \(weekday) the \(day) of \(month)"
			case .long:
				return "Every \(weekday) the \(day) of \(month) at \(time)"
			}
		}
	}

	private static func descriptionWithYearBiggest(_ cronRepresentation: CronRepresentation, length: CronDescriptionLength) -> String {
		let time = DateFormatter.timeStringWithHour(cronRepresentation.hour, minute: cronRepresentation.minute)
		let day = Int(cronRepresentation.day)!.ordinal
		let month = Int(cronRepresentation.month)!.convertToMonth()

		let desc = "\(day) of \(month) \(cronRepresentation.year)"
		if CronRepresentation.isDefault(cronRepresentation.weekday) {
			switch length {
			case .short:
				return desc
			case .long:
				return "\(desc) at \(time)"
			}
		} else {
			let weekday = DateFormatter.convertStringToDaysOfWeek(cronRepresentation.weekday)
			switch length {
			case .short:
				return "\(weekday) \(desc)"
			case .long:
				return "\(weekday) \(desc) at \(time)"
			}
		}
	}
}
