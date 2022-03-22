//
//  HomeMatchesViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 8/2/22.
//

import UIKit
import FSCalendar
import MapKit

class HomeMatchesViewController:  UIViewController {
	
	// MARK: Variables
	var formatter = DateFormatter()
	var matchListViewModel = MatchlistViewModel()
	var pickedDate: String?
	
	// MARK: Outlets
	@IBOutlet weak var calendar: FSCalendar!
	@IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var matchesTableView: UITableView!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Init Values For First Query
		let today = Date()
		formatter.dateFormat = "yyyy-MM-dd"
		let todayFormat = formatter.string(from: today)
		pickedDate = todayFormat
		
		// Init Match List
		matchList()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Calendar Styles
		calendarStyles()
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
		var queryDay: String = ""
		if let pickedDate = pickedDate {
			queryDay = pickedDate
		} else {
			let today = Date()
			formatter.dateFormat = "yyyy-MM-dd"
			let todayFormat = formatter.string(from: today)
			queryDay = todayFormat
		}
		
		matchListViewModel.fetchMatchList(day: queryDay) { [weak self] status, error  in
			if error == nil {
				self?.initTableView()
			} else {
				let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
				vc.modalPresentationStyle = .fullScreen
				vc.modalTransitionStyle = .coverVertical
				vc.errorType = .decodingError
				print("Error 1")
				self?.present(vc, animated: true, completion: nil)
			}
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
		formatter.dateFormat = "yyyy-MM-dd"
		pickedDate = formatter.string(from: date)
		matchList()
		print("Date Selected == \(formatter.string(from: date))")
	}
	
	func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
		calendar.today = nil
		formatter.dateFormat = "yyyy-MM-dd"
		pickedDate = formatter.string(from: date)
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
			
			if match.isOpened {
				cell.arrowImageView.image = UIImage(systemName: "chevron.up")
				cell.bottomConstraint.constant = 0
			} else {
				cell.arrowImageView.image = UIImage(systemName: "chevron.down")
				cell.bottomConstraint.constant = 5
			}
			
			cell.setCellWithValueOf(match)
			return cell
		} else {
			guard let detailCell = tableView.dequeueReusableCell(withIdentifier: "MatchesDetailTableViewCell") as? MatchesDetailTableViewCell else { return UITableViewCell() }
			
			if let matches = matchListViewModel.cellForRowAt(indexPath: indexPath).items {
				let match = matches[indexPath.row - 1]
				detailCell.setCellWithValueOf(match)
			}
			
			return detailCell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if indexPath.row == 0 {
			matchListViewModel.reloadSections(indexPath: indexPath)
			self.matchesTableView.reloadSections([indexPath.section], with: .automatic)
		} else {
			if let matches = matchListViewModel.cellForRowAt(indexPath: indexPath).items {
				let match = matches[indexPath.row - 1]
				let vc = UIStoryboard(name: "PayResume", bundle: nil).instantiateViewController(withIdentifier: "PayResume") as! PayResumeViewController
				vc.reserveType = .matchReserve
				vc.match = match
				vc.reserveDay = pickedDate
				self.present(vc, animated: true)
			}
		}
	}
}
