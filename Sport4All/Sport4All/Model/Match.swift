//
//  Match.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 16/3/22.
//

import Foundation

struct MatchHour: Codable {
	// Hora Que Corresponde
	let hour: [Match]?
	
	enum CodingKeys: String, CodingKey {
		case hour = "13:00:00"
	}
}

struct Match: Codable {
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
		case startTime = "start_time"
		case endTime = "end_time"
		case finalTime = "final_time"
		case startDatetime = "start_Datetime"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}
}
