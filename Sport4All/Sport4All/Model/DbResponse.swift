//
//  DbResponse.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 31/1/22.
//

import Foundation

struct Response: Decodable {
	let status: Int?
	let data: User?
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}

struct ClubListResponse: Decodable {
	let status: Int?
	let data: [Club]?
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}

