//
//  NSNumberFormatter+Extensions.swift
//  Pods
//
//  Created by Keegan Rush on 2016/05/12.
//
//

import Foundation

extension Int: CronFieldTranslatable {
	public var cronFieldRepresentation: String {
		return String(self)
	}
}

extension Int {
	private static let ordinalNumberFormatter: NumberFormatter = {
			let formatter = NumberFormatter()
			if #available(iOS 9, OSX 10.11, *) {
				formatter.numberStyle = .ordinal
			}
			return formatter
	}()

	private static let monthFormatter: DateFormatter = {
			let formatter = DateFormatter()
			formatter.dateFormat = "MMMM"
			return formatter
	}()

	var ordinal: String {
        return Int.ordinalNumberFormatter.string(from: NSNumber(value: self))!
	}

	func convertToMonth() -> String {
		assert(self < 13 && self > 0, "Not a valid month")

		let calendar = Calendar.current
		var components = DateComponents()
		components.month = self
		let date = calendar.date(from: components)!
		return Int.monthFormatter.string(from: date)
	}
}
