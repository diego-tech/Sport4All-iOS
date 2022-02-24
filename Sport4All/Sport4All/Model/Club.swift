//
//  Club.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/2/22.
//

import Foundation

struct Club: Decodable {
	let id: Int?
	let name: String?
	let club_img: String?
	let club_banner: String?
	let direction: String?
	let tlf: String?
	let email: String?
	let createdAt: Date?
	let updatedAt: Date?
	
	enum CodingKeys: String, CodingKey {
		case id, name, club_img, club_banner, direction, tlf, email
		case createdAt = "created_at"
		case updatedAt = "updated_at"
	}
}
