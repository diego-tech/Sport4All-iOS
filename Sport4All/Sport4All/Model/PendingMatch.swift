//
//  PendingMatch.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 16/3/22.
//

import Foundation

struct PendingMatch: Codable {
	let id: Int?
	let qr: String?
	let userId: Int?
	let clubId: Int?
	let clubImg: String?
	let courtId: Int?
	let pricePeople: Int?
	let lights: Int?
	let day: String?
	let startTime: String?
	let endTime: String?
	let finalTime: String?
	let startDatetime: String?
	let clubName: String?
	let clubLocation: String?
	let courtName: String?
	let courtType: String?
	let sportType: String?
	let surfaces: String?
	let createdAt: String?
	let updatedAt: String?
	
	// MARK: Event Values
	let eventName: String?
	let eventImg: String?
	
	
	let pendingType: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case qr = "QR"
		case userId = "user_id"
		case clubId = "club_id"
		case courtId = "court_id"
		case pricePeople = "price_people"
		case lights
		case day
		case clubImg
		case eventName
		case eventImg
		case startTime = "start_time"
		case endTime = "end_time"
		case finalTime = "final_time"
		case startDatetime = "start_datetime"
		case clubName
		case clubLocation
		case courtName = "name"
		case courtType = "type"
		case sportType = "sport"
		case surfaces
		case pendingType = "pending_type"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}
}

enum PendingType: String {
	case match
	case event
	case reserve
}
