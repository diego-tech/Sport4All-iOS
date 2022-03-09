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
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var calendar: FSCalendar!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		calendar.appearance.titleFont = UIFont(name: FontType.SFProDisplaySemibold.rawValue, size: 15)
		calendar.appearance.headerTitleFont = UIFont(name: FontType.SFProSemibold.rawValue, size: 15)
		calendar.appearance.weekdayFont = UIFont(name: FontType.SFProSemibold.rawValue, size: 10)
		self.calendar.scope = .week
		
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
		
		calendar.dataSource = self
		calendar.delegate = self
		
		// Configure Navbar
		configureNavbar()
	}
	
	@IBAction func buttonTest(_ sender: Any) {
		print("Tap")
	}
	
	// MARK: Functions
	
	// MARK: Styles
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
	
	func maximumDate(for calendar: FSCalendar) -> Date {
		return Date().addingTimeInterval((24 * 60 * 60) * 60)
	}
	
	// MARK: Delegate
	func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
		formatter.dateFormat = "dd-MMM-yyyy"
		print("Date Selected == \(formatter.string(from: date))")
	}
	
	func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
		formatter.dateFormat = "dd-MMM-yyyy"
		print("Date Selected == \(formatter.string(from: date))")
	}
	
	func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
		formatter.dateFormat = "dd-MMM-yyyy"
		
		guard let excludedDate = formatter.date(from: "23-03-2022") else { return true }
		
		if date.compare(excludedDate) == .orderedSame {
			return false
		}
		
		return true
	}
}
