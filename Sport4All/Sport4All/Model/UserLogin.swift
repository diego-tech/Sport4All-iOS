//
//  UserLogin.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 31/1/22.
//

import Foundation

struct UserLogin: Encodable {
	let email: String?
	let password: String?
	
	enum CodingKeys: String, CodingKey {
		case email
		case password
	}
}
