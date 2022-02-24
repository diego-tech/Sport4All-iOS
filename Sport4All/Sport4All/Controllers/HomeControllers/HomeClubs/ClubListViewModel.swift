//
//  ClubListViewModel.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/2/22.
//

import Alamofire
import Foundation

class ClubListViewModel {
	
	private var clubList = [Club]()
	private var status = Int()
	
	func fetchClubList(completion: @escaping (_ status: Int?) -> ()) {
		NetworkingProvider.shared.clubList { responseData, status, msg in
			guard let responseList = responseData else { return }
			guard let status = status else { return }
			self.status = status
			self.clubList = responseList
			completion(status)
		} failure: { error in
			debugPrint(error)
		}
	}
	
	func numberOfRowsInSection(section: Int) -> Int {
		if clubList.count != 0 {
			return clubList.count
		}
		return 0
	}
	
	func cellForRowAt(indexPath: IndexPath) -> Club {
		return clubList[indexPath.row]
	}
}
