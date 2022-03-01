//
//  EventPendingListViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 23/2/22.
//

import UIKit

class EventPendingListViewController: UIViewController {
	
	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var pendingEventsList: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		pendingEventsList.dataSource = self
		pendingEventsList.delegate = self
		pendingEventsList.isScrollEnabled = true
		pendingEventsList.register(UINib.init(nibName: "ClubTableViewCell", bundle: nil), forCellReuseIdentifier: "ClubTableViewCell")
		pendingEventsList.separatorStyle = .none
		pendingEventsList.showsHorizontalScrollIndicator = false
		pendingEventsList.showsVerticalScrollIndicator = false
    }
	
	// MARK: Action Functions
	
	// MARK: Functions
	
	// MARK: Styles
}

extension EventPendingListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 15
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = pendingEventsList.dequeueReusableCell(withIdentifier: "ClubTableViewCell") as! ClubTableViewCell
		
		return cell
	}
}
