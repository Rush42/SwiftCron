import Foundation

class MinutesField: Field, FieldCheckerInterface {

	func isSatisfiedBy(_ date: Date, value: String) -> Bool {
		let calendar = Calendar.current
		let components = calendar.dateComponents([.minute], from: date)

        guard let minute = components.minute else { return false }

		return self.isSatisfied(String(format: "%d", minute), value: value)
	}

	func increment(_ date: Date, toMatchValue: String) -> Date {
		if let nextDate = date.nextDate(matchingUnit: .minute, value: toMatchValue) {
			return nextDate
		}

		let calendar = Calendar.current
		var components = DateComponents()
		components.minute = 1

		return calendar.date(byAdding: components, to: date)!
	}

	func validate(_ value: String) -> Bool {
		return StringValidator.isNumber(value)
	}
}
