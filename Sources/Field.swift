import Foundation

typealias FieldChecker = Field & FieldCheckerInterface

class Field {
	var fields: NSMutableArray?
    var calendar: Calendar
    
    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }

	func isSatisfied(_ dateValue: String, value: String) -> Bool {
		return value == CronRepresentation.DefaultValue || dateValue == value
	}
}
