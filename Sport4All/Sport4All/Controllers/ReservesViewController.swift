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
	var club: Club?
	private var firstHourToReserve: String?
	private var lastHourToReserve: String?
	private var firstHourInt: Int = 0
	private var lastHourInt: Int = 0
	
	private let today = Date()
	private var dateFormatter = DateFormatter()
	private var tableViewModel = CourtsListViewModel()
	
	private var pickedDate: String?
	private var pickedTime: String?
	
	private var pickerView = UIPickerView()
	private var halfMinutes: [String] = ["00", "30"]
	
	private var times = [String]()
	private var hour = String()
	private var minute = String()
	
	// MARK: Outlets
	@IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
	@IBOutlet weak var calendar: FSCalendar!
	@IBOutlet weak var clubBannerImageView: LazyImageView!
	@IBOutlet weak var clubNameLabel: UILabel!
	@IBOutlet weak var reservesTableView: UITableView!
	@IBOutlet weak var hourTextField: UITextField!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Init Values For First Query
		dateFormatter.dateFormat = "yyyy-MM-dd"
		let todayFormat = dateFormatter.string(from: today)
		pickedDate = todayFormat
		dateFormatter.dateFormat = "HH:mm:ss"
		let nowTime = dateFormatter.string(from: today)
		pickedTime = nowTime
		hourTextField.text = pickedTime
	
		// Init Table View
		courtList()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Configure Models
		configure()
		
		// Configure Navbar
		configureNavbar()
		
		// Calendar Styles
		calendarStyles()
		
		// Picker View Delegate, DataSource and Styles
		pickerView.delegate = self
		pickerView.dataSource = self
		pickerViewStyles()
	}
	
	// MARK: Action Functions
	@objc func donePressed() {
		pickedTime = "\(hour):\(minute):00"
		hourTextField.text = pickedTime
		hourTextField.resignFirstResponder()
		
		// Init Table View
		courtList()
	}
	
	// MARK: Functions
	private func configure() {
		guard let club = club else { return debugPrint("Error Club") }
		guard let banner = club.clubBanner else { return debugPrint("Error Banner") }
		guard let name = club.name else { return debugPrint("Error Name") }
		guard let bannerUrl = URL(string: Constants.kStorageURL + banner) else { return debugPrint("Error Url Imagen") }
		guard let firstHourToReserve = club.firstHourToReserve else { return debugPrint("First Hour Error") }
		guard let lastHourToReserve = club.lastHourToReserve else { return debugPrint("Last Hour Error") }
		
		self.firstHourToReserve = firstHourToReserve
		self.lastHourToReserve = lastHourToReserve
		self.clubBannerImageView.loadImage(fromURL: bannerUrl)
		self.clubNameLabel.text = name
		
		firstHourInt = AuxFunctions.formatTimeToInt(hour: firstHourToReserve)
		lastHourInt = AuxFunctions.formatTimeToInt(hour: lastHourToReserve)
		
		// Hours
		times = AuxFunctions.getTimeList(openingTime: firstHourInt, closingTime: lastHourInt)
	}
	
	private func courtList() {
		var queryCourt: QueryCourt?
		if let clubId = club?.id, let day = pickedDate, let time = pickedTime {
			queryCourt = QueryCourt(club_id: clubId, day: day, hour: time)
		}		
		guard let queryCourt = queryCourt else { return }

		tableViewModel.fetchFreeCourts(queryCourt: queryCourt) { [weak self] status in
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
	
	private func initTableView() {
		reservesTableView.dataSource = self
		reservesTableView.delegate = self
		reservesTableView.isScrollEnabled = true
		reservesTableView.register(UINib.init(nibName: "ReservesTableViewCell", bundle: nil), forCellReuseIdentifier: "ReservesTableViewCell")
		reservesTableView.separatorStyle = .none
		reservesTableView.showsHorizontalScrollIndicator = false
		reservesTableView.showsVerticalScrollIndicator = true
		reservesTableView.reloadData()
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
	
	private func pickerViewStyles() {
		// Toolbar
		let toolBar = UIToolbar()
		toolBar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
		toolBar.isTranslucent = true
		toolBar.backgroundColor = .softBlue
		toolBar.tintColor = .hardColor
		toolBar.sizeToFit()
		
		// Done Button
		let doneButton = UIBarButtonItem(title: "Aceptar", style: .done, target: self, action: #selector(donePressed))
		toolBar.setItems([doneButton], animated: true)
		
		// Text Field
		hourTextField.bottomBorder(color: .hardColor ?? .black)
		hourTextField.placeholderStyles(placeHolderText: "Hora")
		hourTextField.textStyles(keyboardType: .default)
		hourTextField.inputView = pickerView
		hourTextField.inputAccessoryView = toolBar
		hourTextField.tintColor = .hardColor
		
		// Picker View
		pickerView.backgroundColor = .softBlue
		pickerView.tintColor = .hardColor
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
		dateFormatter.dateFormat = "yyyy-MM-dd"
		pickedDate = dateFormatter.string(from: date)
		debugPrint("Date Selected == \(dateFormatter.string(from: date))")
	}
	
	func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
		calendar.today = nil
		dateFormatter.dateFormat = "yyyy-MM-dd"
		pickedDate = dateFormatter.string(from: date)
		debugPrint("Date Selected == \(dateFormatter.string(from: date))")
	}
	
	func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
		self.calendarHeightConstraint.constant = bounds.height
		self.view.layoutIfNeeded()
	}
}

// MARK: TableView Delegate and DataSource
extension ReservesViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return tableViewModel.numberOfSections()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewModel.numberOfRowsInSection(section: section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.row == 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReservesTableViewCell") as? ReservesTableViewCell else { return UITableViewCell() }
			let court = tableViewModel.cellForRowAt(indexPath: indexPath)
			cell.setCellWithValueOf(court)
			return cell
		} else {
			guard let detailCell = tableView.dequeueReusableCell(withIdentifier: "ReservesDetailTableViewCell") as? ReservesDetailTableViewCell else { return UITableViewCell() }
			let prices = tableViewModel.cellForRowAt(indexPath: indexPath).prices
			if let prices = prices {
				detailCell.configure(prices)
				detailCell.reservesDetailCell = self
			}
			
			return detailCell
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if indexPath.row == 0 {
			tableViewModel.reloadSections(indexPath: indexPath)
			self.reservesTableView.reloadSections([indexPath.section], with: .automatic)
		}
	}
}

// MARK: UIDatePickerView Delegate and DataSource
extension ReservesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 2
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		switch component {
		case 0:
			return times.count
		case 1:
			return halfMinutes.count
		default:
			return 0
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
		var label: UILabel

		if let view = view as? UILabel {
			label = view
		} else {
			label = UILabel()
		}

		label.textColor = .hardColor
		label.textAlignment = .center
		label.font = UIFont(name: FontType.SFProMedium.rawValue, size: 20)

		var text = ""

		switch component {
		case 0:
			text = times[row]
			hour = times[row]
		case 1:
			text = halfMinutes[row]
			minute = halfMinutes[row]
		default:
			break
		}

		label.text = text
		return label
	}
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		if component == 0 {
			hour = times[row]
		} else if component == 1 {
			minute = halfMinutes[row]
		}
	}
	
	func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
		let attributes = [
			NSAttributedString.Key.foregroundColor: UIColor.hardColor ?? UIColor.black
		]
		
		return NSAttributedString(
			string: AuxFunctions.getTimeList(openingTime: firstHourInt, closingTime: lastHourInt)[row],
			attributes: attributes
		)
	}
}

// MARK: ReservesDetailTableViewCell Delegate
extension ReservesViewController: ReservesDetailTableViewCellDelegate {
	func didSelectPrice(_ cell: ReservesDetailTableViewCell, didSelectPrice price: Price) {
		let vc = UIStoryboard(name: "PayResume", bundle: nil).instantiateViewController(withIdentifier: "PayResume") as! PayResumeViewController
		modalPresentationStyle = .automatic
		self.present(vc, animated: true, completion: nil)
		
		print(price)
	}
}
