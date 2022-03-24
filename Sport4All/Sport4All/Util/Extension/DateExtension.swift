//
//  DateExtension.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/3/22.
//

import Foundation

extension Date {
	func nearestHour() -> Date? {
		var components = NSCalendar.current.dateComponents([.minute], from: self)
		let minute = components.minute ?? 0
		components.minute = minute >= 30 ? 60 - minute : -minute
		return Calendar.current.date(byAdding: components, to: self)
	}
}
