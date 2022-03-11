//
//  ReservesViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 8/3/22.
//

import UIKit
import FSCalendar

class ReservesViewController: UIViewController {
	
	// MARK: Variables
	var formatter = DateFormatter()
	
	// MARK: Outlets
	@IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var timePicker: UIDatePicker!
	@IBOutlet weak var calendar: FSCalendar!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Configure Navbar
		configureNavbar()
		
		// Calendar Styles
		calendarStyles()
		
		// Time Picker Styles
		timePicker.tintColor = .hardColor
		timePicker.subviews.first?.semanticContentAttribute = .forceRightToLeft
	}
	
	@IBAction func buttonTest(_ sender: Any) {
		print("Tap")
	}
	
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
	
	private func configureNavbar() {
		self.navigationController!.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		
		title = "RESERVAR"
		
		let yourBackImage = UIImage(systemName: "arrowshape.turn.up.backward.fill", withConfiguration:  UIImage.SymbolConfiguration(pointSize: 18))
		let backButtonItem = UIBarButtonItem(image: yourBackImage, style: .plain, target: self, action: #selector(popView(tapGestureRecognizer:)))
		backButtonItem.tintColor = .corporativeColor
		
		self.navigationItem.leftBarButtonItem = backButtonItem
		
		self.navigationItem.setHidesBackButton(true, animated: true)
	}
	
	@objc func popView(tapGestureRecognizer: UITapGestureRecognizer) {
		self.navigationController?.popViewController(animated: true)
	}
}

extension ReservesViewController: FSCalendarDelegate, FSCalendarDataSource {
	// MARK: DataSource
	func minimumDate(for calendar: FSCalendar) -> Date {
		return Date()
	}
	
	// MARK: Delegate
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
