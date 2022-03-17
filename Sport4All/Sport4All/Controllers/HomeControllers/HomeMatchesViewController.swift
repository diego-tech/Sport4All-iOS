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
	var matchListViewModel = MatchlistViewModel()
	
	// MARK: Outlets
	@IBOutlet weak var calendar: FSCalendar!
	@IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var matchesTableView: UITableView!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Init Match List
		matchList()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Calendar Styles
		calendarStyles()
		
		// Init Table View
//		initTableView()
	}
	
	// MARK: Action Functions
	
	// MARK: Functions
	private func initTableView() {
		matchesTableView.dataSource = self
		matchesTableView.delegate = self
		matchesTableView.isScrollEnabled = true
		matchesTableView.register(UINib.init(nibName: "MatchesMainTableViewCell", bundle: nil), forCellReuseIdentifier: "MatchesMainTableViewCell")
		matchesTableView.separatorStyle = .none
		matchesTableView.showsHorizontalScrollIndicator = false
		matchesTableView.showsVerticalScrollIndicator = false
		matchesTableView.reloadData()
	}
	
	private func matchList() {
		matchListViewModel.fetchMatchList { [weak self] status in
			self?.initTableView()
		}
	}
	
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
		calendar.locale = Locale(identifier: "ES")
		
		calendar.dataSource = self
		calendar.delegate = self
	}
}

// MARK: FSCalendar Delegate && DataSource
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

// MARK: UITableView Delegate && DataSource
extension HomeMatchesViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return matchListViewModel.numberOfSections()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return matchListViewModel.numberOfRowsInSection(section: section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchesMainTableViewCell") as? MatchesMainTableViewCell else { return UITableViewCell() }
			let match = matchListViewModel.cellForRowAt(indexPath: indexPath)
			return cell
		} else {
			guard let detailCell = tableView.dequeueReusableCell(withIdentifier: "MatchesDetailTableViewCell") as? MatchesDetailTableViewCell else { return UITableViewCell() }
			return detailCell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		print("Tapped")
		
		if indexPath.row == 0 {
			matchListViewModel.reloadSections(indexPath: indexPath)
			self.matchesTableView.reloadSections([indexPath.section], with: .automatic)
		}
	}
}
