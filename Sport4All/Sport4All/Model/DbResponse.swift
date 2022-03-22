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
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}

struct EventListResponse: Codable {
	let status: Int?
	let data: [Event]?
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}

struct MatchListResponse: Codable {
	let status: Int?
	let data: [Match]?
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}

struct PendingOrFinishListResponse: Codable {
	let status: Int?
	let data: [PendingOrFinishEvent]?
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}

struct ReserveResponse: Codable {
	let status: Int?
	let data: Reserve?
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}

struct MatchInscriptionResponse: Codable {
	let status: Int?
	let data: MatchInscription?
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}

struct InscriptionEventResponse: Codable {
	let status: Int?
	let data: Inscription?
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}

struct LogOutResponse: Codable {
	let status: Int?
	let msg: String?

	enum CodingKeys: String, CodingKey {
		case status
		case msg
	}
}

struct InfoClubResponse: Codable {
	let status: Int?
	let data: Club?
	let msg: String?
	
	enum CodingKeys: String, CodingKey {
		case status
		case data
		case msg
	}
}
