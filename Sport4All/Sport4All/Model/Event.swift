//
//  Event.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 12/3/22.
//

import Foundation

struct Event: Codable {
	let id: Int?
	let club_id: Int?
	let name: String?
	let visibility: String?
	let peopleLeft: Int?
	let description: String?
	let type: String?
	let price: Int?
	let img: String?
	let clubName: String?
	let clubLocation: String?
	let startTime: String?
	let endTime: String?
	let finalDate: String?
	let createdAt: String?
	let updatedAt: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case club_id
		case name
		case visibility
		case peopleLeft = "people_left"
		case description
		case type
		case price
		case img
		case clubName
		case clubLocation
		case startTime = "start_time"
		case endTime = "end_time"
		case finalDate = "final_time"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}
}
