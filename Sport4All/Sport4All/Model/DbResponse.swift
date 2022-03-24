//
//  DbResponse.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 31/1/22.
//

import Foundation

struct UploadImageResponse: Codable {
	let status: Int?
	let msg: String?
}

struct Response: Codable {
	let status: Int?
	let data: User?
	let msg: String?
}

struct ClubListResponse: Codable {
	let status: Int?
	let data: [Club]?
	let msg: String?
}

struct FreeCourtsResponse: Codable {
	let status: Int?
	let data: [Court]?
	let msg: String?
}

struct EventListResponse: Codable {
	let status: Int?
	let data: [Event]?
	let msg: String?
}

struct MatchListResponse: Codable {
	let status: Int?
	let data: [Match]?
	let msg: String?
}

struct PendingOrFinishListResponse: Codable {
	let status: Int?
	let data: [PendingOrFinishEvent]?
	let msg: String?
}

struct ReserveResponse: Codable {
	let status: Int?
	let data: Reserve?
	let msg: String?
}

struct MatchInscriptionResponse: Codable {
	let status: Int?
	let data: MatchInscription?
	let msg: String?
}

struct InscriptionEventResponse: Codable {
	let status: Int?
	let data: Inscription?
	let msg: String?
}

struct LogOutResponse: Codable {
	let status: Int?
	let msg: String?
}

struct InfoClubResponse: Codable {
	let status: Int?
	let data: Club?
	let msg: String?
}

struct CheckHasTokenResponse: Codable {
	let status: Int?
	let msg: String?
}
