//
//  Data.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 31/1/22.
//

import Foundation

struct Data: Decodable {
	let id: Int?
	let name: String?
	let surname: String?
	let image: String?
	let email: String?
	let genre: String?
	let updatedAt: Date?
	let createdAt: Date?
		
	// Validator Errors
	let errors: String?
	
	// User Token
	let token: String?
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case surname
		case image
		case email
		case genre
		case errors
		case updatedAt = "updated_at"
		case createdAt = "created_at"
		case token
	}
}


