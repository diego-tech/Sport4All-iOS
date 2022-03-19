//
//  Inscription.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 19/3/22.
//

import Foundation

struct Inscription: Codable {
	let id: Int?
	let eventId: Int?
	let userId: Int?
	let updatedAt: Date?
	let createdAt: Date?
	
	enum CodingKeys: String, CodingKey {
		case id
		case eventId = "event_id"
		case userId = "user_id"
		case updatedAt = "updated_at"
		case createdAt = "created_at"
	}
}
