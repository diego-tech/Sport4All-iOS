//
//  EventPendingListViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 23/2/22.
//

import UIKit

class EventPendingListViewController: UIViewController {
	
	// Variables
	
	// Outlets
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
