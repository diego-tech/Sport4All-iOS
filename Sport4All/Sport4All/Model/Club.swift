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
	let club_img: String?
	let club_banner: String?
	let direction: String?
	let tlf: String?
	let description: String?
	let services: [ClubService]?
	let fav: Bool?
	let web: String?
	let created_at: String?
	let updated_at: String?
}

struct ClubService: Codable {
	let name: String?
}
