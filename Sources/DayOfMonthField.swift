import Foundation

class DayOfMonthField: Field, FieldCheckerInterface {
	func isSatisfiedBy(_ date: Date, value: String) -> Bool {
		let calendar = Calendar.current
		let components = calendar.dateComponents([.day, .month, .year], from: date)

		if value == "L" {
			return components.day == date.getLastDayOfMonth()
		}

        let day = components.day!
		return self.isSatisfied(String(day), value: value)
	}

	func increment(_ date: Date, toMatchValue: String) -> Date {
		if let nextDate = date.nextDate(matchingUnit: .day, value: toMatchValue) {
			return nextDate
		}

		let calendar = Calendar.current
		var midnightComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .weekday], from: date)
		midnightComponents.hour = 0
		midnightComponents.minute = 0
		midnightComponents.second = 0

		var components = DateComponents()
		components.day = 1
        return calendar.date(byAdding: components, to: calendar.date(from: midnightComponents)!)!
	}

	func validate(_ value: String) -> Bool {
		return StringValidator.isAlphanumeric(value)
	}
}
