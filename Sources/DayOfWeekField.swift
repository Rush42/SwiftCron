import Foundation

class DayOfWeekField: Field, FieldCheckerInterface {
	static let currentCalendarWithMondayAsFirstDay: Calendar = {
		var calendar = Calendar.current
		calendar.firstWeekday = 2
		return calendar
	}()

	func isSatisfiedBy(_ date: Date, value: String) -> Bool {
		let valueToSatisfy = value

		let calendar = DayOfWeekField.currentCalendarWithMondayAsFirstDay
        var weekdayWithMondayAsFirstDay = calendar.ordinality(of: .weekday, in: .weekOfYear, for: date)!

		if Int(valueToSatisfy) == 0 {
			weekdayWithMondayAsFirstDay = 0
		}

		return self.isSatisfied(String(format: "%d", weekdayWithMondayAsFirstDay), value: valueToSatisfy)
	}

	func increment(_ date: Date, toMatchValue: String) -> Date {
		let calendar = Calendar.current

		// TODO issue 13: handle list items
		if let toMatchInt = Int(toMatchValue) {
			let converted = Date.convertWeekdayWithMondayFirstToSundayFirst(toMatchInt)
			if let nextDate = date.nextDate(matchingUnit: .weekday, value: String(converted)) {
				return nextDate
			}
		}

		let midnightComponents = calendar.dateComponents([.day, .month, .year], from: date)
		var components = DateComponents()
		components.day = 1
        return calendar.date(byAdding: components, to: calendar.date(from: midnightComponents)!)!
	}

	func validate(_ value: String) -> Bool {
		return StringValidator.isUpperCaseOrNumber(value)
	}
}
