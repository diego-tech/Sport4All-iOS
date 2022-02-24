//
//  Club.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 24/2/22.
//

import Foundation

struct Club: Codable {
	let id: Int?
	let name: String?
	let club_img: String?
	let club_banner: String?
	let direction: String?
	let tlf: String?
	let email: String?
	let created_at: String?
	let updated_at: String?
}

/**
 "id": 1,
			 "name": "Club Prueba 1",
			 "club_img": "club.png",
			 "club_banner": "clubebanner.ong",
			 "direction": "Hola",
			 "tlf": "123123121",
			 "email": "pepe@pepe.com",
			 "created_at": "2022-02-24T11:12:01.000000Z",
			 "updated_at": "2022-02-24T11:12:01.000000Z"
 */
