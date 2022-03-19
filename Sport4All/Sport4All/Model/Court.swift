//
//  Court.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 11/3/22.
//

import Foundation

struct Court: Codable {
	let id: Int?
	let club_id: Int
	let name: String?
	let type: String?
	let prices: [Price]?
	let surfaces: String?
	let updatedAt: Date?
	let createdAt: Date?
	
	// Variable To Make Expandable List
	var isOpened: Bool = false
	
	enum CodingKeys: String, CodingKey {
		case id
		case club_id
		case name
		case type
		case prices
		case surfaces
		case updatedAt = "updated_at"
		case createdAt = "created_at"
	}
}

struct Price: Codable {
	let id: Int
	let price: Double
	let time: Double
	let updatedAt: Date?
	let createdAt: Date?
	
	enum CodingKeys: String, CodingKey {
		case id
		case price
		case time
		case updatedAt = "updated_at"
		case createdAt = "created_at"
	}
}

struct QueryCourt: Codable {
	let club_id: Int
	let day: String
	let hour: String
}
