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
	var club: Club?
	private var sections = [Section]()
	
	// MARK: Outlets
	@IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var timePicker: UIDatePicker!
	@IBOutlet weak var calendar: FSCalendar!
	@IBOutlet weak var clubBannerImageView: LazyImageView!
	@IBOutlet weak var clubNameLabel: UILabel!
	@IBOutlet weak var reservesTableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		sections = [
			Section(title: "Section 1", options: [1], isOpened: true),
			Section(title: "Section 2", options: [1]),
			Section(title: "Section 3", options: [1]),
			Section(title: "Section 3", options: [1]),
			Section(title: "Section 3", options: [1])
		]
		
		// Configure Models
		configure()
		
		// Configure Navbar
		configureNavbar()
		
		// Calendar Styles
		calendarStyles()
		
		// Time Picker Styles
		timePicker.tintColor = .hardColor
		timePicker.subviews.first?.semanticContentAttribute = .forceRightToLeft
		
		// Init Table View
		reservesTableView.dataSource = self
		reservesTableView.delegate = self
		reservesTableView.isScrollEnabled = true
		reservesTableView.register(UINib.init(nibName: "ReservesTableViewCell", bundle: nil), forCellReuseIdentifier: "ReservesTableViewCell")
		reservesTableView.separatorStyle = .none
		reservesTableView.showsHorizontalScrollIndicator = false
		reservesTableView.showsVerticalScrollIndicator = true
		reservesTableView.reloadData()
	}
	
	// MARK: Action Functions
	
	// MARK: Functions
	private func configure() {
		guard let club = club else { return debugPrint("Error Club") }
		guard let banner = club.club_banner else { return debugPrint("Error Banner") }
		guard let name = club.name else { return debugPrint("Error Name") }
		guard let bannerUrl = URL(string: Constants.kStorageURL + banner) else { return debugPrint("Error Url Imagen") }
		self.clubBannerImageView.loadImage(fromURL: bannerUrl)
		self.clubNameLabel.text = name
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

// MARK: FS Calendar Delegate and Data Source
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

// MARK: TableView Delegate and DataSource
extension ReservesViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return sections.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let section = sections[section]

		if section.isOpened {
			return section.options.count + 1
		} else {
			return 1
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReservesTableViewCell") as? ReservesTableViewCell else { return UITableViewCell() }
			return cell
		} else {
			guard let detailCell = tableView.dequeueReusableCell(withIdentifier: "ReservesDetailTableViewCell") as? ReservesDetailTableViewCell else { return UITableViewCell() }
			return detailCell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if indexPath.row == 0 {
			sections[indexPath.section].isOpened = !sections[indexPath.section].isOpened
			self.reservesTableView.reloadSections([indexPath.section], with: .automatic)
		} else {
			print("Tap")
		}
	}
}

struct Section{
	let title: String
	let options: [Int]
	var isOpened: Bool = false
}
