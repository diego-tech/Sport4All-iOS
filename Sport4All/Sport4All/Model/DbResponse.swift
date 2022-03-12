//
//  DbResponse.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 31/1/22.
//

import Foundation

struct Response: Codable {
	let status: Int?
	let data: User?
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}

struct ClubListResponse: Codable {
	let status: Int?
	let data: [Club]?
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}

struct FreeCourtsResponse: Codable {
	let status: Int?
	let data: [Court]?
	let msg: String?
	
	enum Codingkeys: String, CodingKey {
		case status
		case data
		case msg
	}
}

