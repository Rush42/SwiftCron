import Foundation

class HoursField: Field, FieldCheckerInterface {

	func isSatisfiedBy(_ date: Date, value: String) -> Bool {
		let calendar = Calendar.current
		let components = calendar.dateComponents([.hour], from: date)
        guard let hour = components.hour else { return false }

		return isSatisfied(String(format: "%d", hour), value: value)
	}

	func increment(_ date: Date, toMatchValue: String) -> Date {
		if let nextDate = date.nextDate(matchingUnit: .hour, value: toMatchValue) {
			return nextDate
		}

		let calendar = Calendar.current
		var components = DateComponents()
		components.hour = 1
        return calendar.date(byAdding: components, to: date)!
	}

	func validate(_ value: String) -> Bool {
        return StringValidator.isNumber(value)
	}
}
