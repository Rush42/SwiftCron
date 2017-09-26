import Foundation

class Field {
	var fields: NSMutableArray?

	func isSatisfied(_ dateValue: String, value: String) -> Bool {
		return value == CronRepresentation.DefaultValue || dateValue == value
	}
}
