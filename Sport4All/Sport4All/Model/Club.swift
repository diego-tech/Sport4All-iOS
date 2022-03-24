//
//  Club.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/2/22.
//

import Foundation

struct Club: Codable {
	let id: Int?
	let name: String?
	let email: String?
	let clubImg: String?
	let clubBanner: String?
	let direction: String?
	let tlf: String?
	let description: String?
	let services: [ClubService]?
	let fav: Bool?
	let web: String?
	let firstHourToReserve: String?
	let lastHourToReserve: String?
	let createdAt: String?
	let updatedAt: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case email
		case clubImg = "club_img"
		case clubBanner = "club_banner"
		case direction
		case tlf
		case description
		case services
		case fav
		case web
		case firstHourToReserve = "first_hour"
		case lastHourToReserve = "last_hour"
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}
}

struct ClubService: Codable {
	let name: String?
}
