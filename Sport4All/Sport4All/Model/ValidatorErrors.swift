//
//  ValidatorErrors.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 1/2/22.
//

import Foundation

struct ValidatorErrors: Decodable{
	let name: String?
	let email: String?
	let password: String?
	let genre: String?
	let surname: String?
	let image: String?
	
	enum CodingKeys: String, CodingKey{
		case name
		case email
		case password
		case genre
		case surname
		case image
	}
}
