//
//  Court.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 11/3/22.
//

import Foundation

struct Court {
	let club_id: Int?
	let name: String?
	let type: String?
	let price: Int?
	let id: Int?
	let updatedAt: Date?
	let createdAt: Date?
	
	enum CodingKeys: String, CodingKey {
		case club_id
		case name
		case type
		case price
		case id
		case updatedAt = "updated_at"
		case createdAt = "created_at"
	}
}
