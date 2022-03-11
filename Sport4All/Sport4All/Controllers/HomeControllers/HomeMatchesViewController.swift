//
//  HomeMatchesViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 8/2/22.
//

import UIKit
import FSCalendar

class HomeMatchesViewController:  UIViewController {
	
	// MARK: Variables
	var formatter = DateFormatter()
	
	// MARK: Outlets
	@IBOutlet weak var calendar: FSCalendar!
	@IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Calendar Styles
		calendarStyles()
	}
	
	// MARK: Action Functions
	
	// MARK: Functions
	
	// MARK: Styles
	private func calendarStyles() {
		calendar.appearance.titleFont = UIFont(name: FontType.SFProDisplaySemibold.rawValue, size: 15)
		
		calendar.appearance.headerTitleFont = UIFont(name: FontType.SFProSemibold.rawValue, size: 18)
		
		calendar.appearance.weekdayFont = UIFont(name: FontType.SFProSemibold.rawValue, size: 12)
		
		calendar.appearance.subtitleFont = UIFont(name: FontType.SFProSemibold.rawValue, size: 12)
		
		calendar.scope = .week
		calendar.backgroundColor = .clear
		calendar.appearance.todayColor = .hardColor
		calendar.appearance.titleTodayColor = .backgroundColor
		calendar.appearance.titleDefaultColor = .hardColor
		calendar.appearance.headerTitleColor = .hardColor
		calendar.appearance.weekdayTextColor = .blueLowOpacity
		calendar.appearance.selectionColor = .hardColor
		calendar.appearance.titlePlaceholderColor = .blueLowOpacity
		calendar.appearance.subtitlePlaceholderColor = .blueLowOpacity
		calendar.allowsMultipleSelection = false
		calendar.scrollEnabled = true
		calendar.scrollDirection = .horizontal
		
		calendar.dataSource = self
		calendar.delegate = self
	}
}

extension HomeMatchesViewController: FSCalendarDelegate, FSCalendarDataSource {
	
	func minimumDate(for calendar: FSCalendar) -> Date {
		return Date()
	}
	
	func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
		calendar.today = nil
		formatter.dateFormat = "yyyy/MM/dd"
		print("Date Selected == \(formatter.string(from: date))")
	}
	
	func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
		calendar.today = nil
		formatter.dateFormat = "yyyy/MM/dd"
		print("Date Selected == \(formatter.string(from: date))")
	}
	
	func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
		self.calendarHeightConstraint.constant = bounds.height
		self.view.layoutIfNeeded()
	}
}
