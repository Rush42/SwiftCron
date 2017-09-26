import Foundation

class YearField: Field, FieldCheckerInterface {

	func isSatisfiedBy(_ date: Date, value: String) -> Bool {
		let calendar = Calendar.current
		let components = calendar.dateComponents([.year], from: date)

        guard let year = components.year else { return false }

		return self.isSatisfied(String(format: "%d", year), value: value)
	}

	func increment(_ date: Date, toMatchValue: String) -> Date {
		if let nextDate = date.nextDate(matchingUnit: .year, value: toMatchValue) {
			return nextDate
		}

		let calendar = Calendar.current
		let midnightComponents = calendar.dateComponents([.day, .month, .year], from: date)

		var components = DateComponents()
		components.year = 1

		return calendar.date(byAdding: components, to: calendar.date(from: midnightComponents)!)!
	}

	func validate(_ value: String) -> Bool {
		return StringValidator.isNumber(value)
	}
}
