//
//  Reserve.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 19/3/22.
//

import Foundation

struct Reserve: Codable {
	let id: Int?
	let qr: String?
	let userId: Int?
	let courtId: String?
	let startTime: String?
	let endTime: String?
	let day: String?
	let finalTime: String?
	let startDatetime: String?
	let updatedAt: Date?
	let createdAt: Date?
	let pendingType: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case qr = "QR"
		case userId = "user_id"
		case courtId = "court_id"
		case startTime = "start_time"
		case endTime = "end_time"
		case day
		case finalTime = "final_time"
		case startDatetime = "start_Datetime"
		case updatedAt = "updated_at"
		case createdAt = "created_at"
		case pendingType
	}
}

struct ReserveQuery {
	let club_id: Int
	let court_id: Int
	let lights: Bool = true
	let day: String
	let start_time: String
	let time: Int
}
