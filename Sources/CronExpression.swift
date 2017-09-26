import Foundation
/*
 * * * * *
 | | | | |
 | | | | ---- Weekday
 | | | ------ Month
 | | -------- Day
 | ---------- Hour
 ------------ Minute

 * * * * * *
 | | | | | |
 | | | | | ---- Year
 | | | | ------ Weekday
 | | | -------- Month
 | | ---------- Day
 | ------------ Hour
 -------------- Minute
 */
public class CronExpression {

	var cronRepresentation: CronRepresentation

	public convenience init?(cronString: String) {
		guard let cronRepresentation = CronRepresentation(cronString: cronString) else {
			return nil
		}
		self.init(cronRepresentation: cronRepresentation)
	}

	public convenience init?(minute: CronFieldTranslatable = CronRepresentation.DefaultValue, hour: CronFieldTranslatable = CronRepresentation.DefaultValue, day: CronFieldTranslatable = CronRepresentation.DefaultValue, month: CronFieldTranslatable = CronRepresentation.DefaultValue, weekday: CronFieldTranslatable = CronRepresentation.DefaultValue, year: CronFieldTranslatable = CronRepresentation.DefaultValue) {
		let cronRepresentation = CronRepresentation(minute: minute.cronFieldRepresentation, hour: hour.cronFieldRepresentation, day: day.cronFieldRepresentation, month: month.cronFieldRepresentation, weekday: weekday.cronFieldRepresentation, year: year.cronFieldRepresentation)
		self.init(cronRepresentation: cronRepresentation)
	}

	private init?(cronRepresentation theCronRepresentation: CronRepresentation) {
		cronRepresentation = theCronRepresentation

		let parts = cronRepresentation.cronParts
		for i: Int in 0 ..< parts.count {
			let field = CronField(rawValue: i)!
			if field.getFieldChecker().validate(parts[i]) == false {
				NSLog("\(#function): Invalid cron field value \(parts[i]) at position \(i)")
				return nil
			}
		}
	}

	public var stringRepresentation: String {
		return cronRepresentation.cronString
	}

	// MARK: - Description

	public var shortDescription: String {
		return CronDescriptionBuilder.buildDescription(cronRepresentation, length: .short)
	}

	public var longDescription: String {
		return CronDescriptionBuilder.buildDescription(cronRepresentation, length: .long)
	}

	// MARK: - Get Next Run Date

	public func getNextRunDateFromNow() -> Date? {
		return getNextRunDate(Date())
	}

	public func getNextRunDate(_ date: Date) -> Date? {
		return getNextRunDate(date, skip: 0)
	}

	func getNextRunDate(_ date: Date, skip: Int) -> Date? {
		guard matchIsTheoreticallyPossible(date) else {
			return nil
		}

		var timesToSkip = skip
		let calendar = Calendar.current
		var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .weekday], from: date)
		components.second = 0

		var nextRun = calendar.date(from: components)!

		// MARK: Issue 3: Instantiate enum instances with the right value
		let allFieldsInExpression: Array<CronField> = [.minute, .hour, .day, .month, .weekday, .year]

		// Set a hard limit to bail on an impossible date
		iteration: for _: Int in 0 ..< 1000 {
			var satisfied = false

			currentFieldLoop: for cronField: CronField in allFieldsInExpression {
				// MARK: Issue 3: just call cronField.isSatisfiedBy, or getNextApplicableDate as specified in Issue 2
				let part = cronRepresentation[cronField.rawValue]
				let fieldChecker = cronField.getFieldChecker()

				if part.contains(CronRepresentation.ListIdentifier) == false {
					satisfied = fieldChecker.isSatisfiedBy(nextRun, value: part)
				} else {
					for listPart: String in part.components(separatedBy: CronRepresentation.ListIdentifier) {
						satisfied = fieldChecker.isSatisfiedBy(nextRun, value: listPart)
						if satisfied {
							break
						}
					}
				}

				// If the field is not satisfied, then start over
				if satisfied == false {
					nextRun = fieldChecker.increment(nextRun, toMatchValue: part)
					continue iteration
				}

				// Skip this match if needed
				if timesToSkip > 0 {
					_ = CronField(rawValue: 0)!.getFieldChecker().increment(nextRun, toMatchValue: part)
					timesToSkip -= 1
				}
				continue currentFieldLoop
			}
			return satisfied ? nextRun : nil
		}
		return nil
	}

	private func matchIsTheoreticallyPossible(_ date: Date) -> Bool {
		// TODO: Handle lists and steps
		guard let year = Int(cronRepresentation.year) else {
			return true
		}

		var components = DateComponents()
		components.year = year
		if let month = Int(cronRepresentation.month) {
			components.month = month

            if month < 1 {
                return false
            }
		}
		let day = Int(cronRepresentation.day) ?? Calendar.current.date(from: components)!.getLastDayOfMonth()
		//{
			components.day = day

            if day < 1 {
                return false
            }
		//}
		let dateFromComponents = Calendar.current.date(from: components)!
        return date.compare(dateFromComponents) == .orderedAscending || date.compare(dateFromComponents) == .orderedSame
	}
}
