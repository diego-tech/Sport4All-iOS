//
//  NewUser.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 31/1/22.
//

import Foundation

struct NewUser: Encodable {
	let email: String?
	let password: String?
	let genre: String?
	let name: String?
	let surname: String?
	let image: String?
	
	enum CodingKeys: String, CodingKey {
		case email
		case password
		case genre
		case name
		case surname
		case image
	}
}
