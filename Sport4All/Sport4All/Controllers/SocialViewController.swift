//
//  SocialViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 1/3/22.
//

import UIKit

class SocialViewController: UIViewController {

	// MARK: Variables
	private var tableViewModel = EventsListViewModel()
	
	// MARK: Outlets
	@IBOutlet weak var eventsTableView: UITableView!
	@IBOutlet weak var searchBar: UITextField!
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Set Empty Text in SearchBar when load view
		searchBar.text = ""
		
		// Inicialización Table View
		eventsList()
	}
	
	// MARK: Frame Cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Configure Navbar
		configureNavbar()
		
		// Custom Search Bar
		searchBar.customSearch()
    }
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		view.endEditing(true)
		super.touchesBegan(touches, with: event)
	}
	
	// MARK: Action Functions
	
	
	// MARK: Functions
	private func eventsList() {
		tableViewModel.fetchEventList { [weak self] status in
			self?.initTableView()
		}
	}
	
	private func initTableView() {
		eventsTableView.dataSource = self
		eventsTableView.delegate = self
		eventsTableView.isScrollEnabled = true
		eventsTableView.register(UINib.init(nibName: "EventsTableViewCell", bundle: nil), forCellReuseIdentifier: "EventsTableViewCell")
		eventsTableView.separatorStyle = .none
		eventsTableView.showsHorizontalScrollIndicator = false
		eventsTableView.showsVerticalScrollIndicator = false
		eventsTableView.reloadData()
	}
	
	// MARK: Styles
	private func configureNavbar() {
		// Title Label
		let titleLabel = UILabel()
		titleLabel.textColor = .corporativeColor
		titleLabel.font = UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		titleLabel.text = "Eventos"
		
		// Set Navigation Item
		self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleLabel)
	}
}

extension SocialViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableViewModel.numberOfRowInSection(section: section)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventsTableViewCell") as? EventsTableViewCell else { return UITableViewCell() }
		let event = tableViewModel.cellForRowAt(indexPath: indexPath)
		cell.setCellWithValueOf(event)
		return cell
	}
}
