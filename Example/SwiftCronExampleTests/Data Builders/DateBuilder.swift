//
//  DateBuilder.swift
//  SwiftCronExample
//
//  Created by Keegan Rush on 2016/09/22.
//  Copyright © 2016 Rush42. All rights reserved.
//

import Foundation

class DateBuilder {

    private var day: Int?
    private var month: Int?
    private var year: Int?

    func build() -> Date {
        let components = DateComponents(calendar: Calendar.current, year: year, month: month, day: day)
        return components.date!
    }

    func with(year: Int) -> DateBuilder {
        self.year = year
        return self
    }

    func with(month: Int) -> DateBuilder {
        self.month = month
        return self
    }

    func with(day: Int) -> DateBuilder {
        self.day = day
        return self
    }

}
