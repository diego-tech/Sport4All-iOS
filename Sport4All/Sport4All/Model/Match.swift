//
//  Match.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 16/3/22.
//

import Foundation

struct Match: Codable {
	let startTime: String?
	let items: [MatchItem]?
	
	// Variable To Make Expandable List
	var isOpened: Bool = false
	
	enum CodingKeys: String, CodingKey {
		case startTime = "start_time"
		case items
	}
}

struct MatchItem: Codable {
	let id: Int?
	let qr: String?
	let clubId: Int?
	let courtId: Int?
	let pricePeople: Int?
	let lights: Int?
	let day: String?
	let startTime: String?
	let endTime: String?
	let finalTime: String?
	let startDatetime: String?
	let users: [User]?
	let court: Court?
	let club: Club?
	let createdAt: Date?
	let updatedAt: Date?

	enum CodingKeys: String, CodingKey {
		case id
		case qr = "QR"
		case clubId = "club_id"
		case courtId = "court_id"
		case pricePeople = "price_people"
		case lights
		case day
		case users
		case court = "courts"
		case club = "clubs"
		case startTime = "start_time"
		case endTime = "end_time"
		case finalTime = "final_time"
		case startDatetime = "start_Datetime"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}
}
