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
	let eventName: String?
	let eventImg: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case qr = "QR"
		case userId = "user_id"
		case clubId = "club_id"
		case courtId = "court_id"
		case pricePeople = "price_people"
		case lights
		case day
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
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}
}

/**
 "id": 1,
			 "QR": "5123",
			 "user_id": 1,
			 "court_id": 2,
			 "lights": 1,
			 "day": "2022-03-24",
			 "start_time": "13:00:00",
			 "end_time": "14:00:00",
			 "final_time": "2022-03-24 14:00:00",
			 "start_Datetime": "2022-03-24 13:00:00",
			 "created_at": "2022-03-16 18:29:18",
			 "updated_at": "2022-03-16 18:29:18",
			 "clubName": "Admin",
			 "clubLocation": null,
			 "name": "Pista de Prueba 1",
			 "type": "Outdoor",
			 "sport": "Tenis",
			 "surfaces": "Hierba"
 */
