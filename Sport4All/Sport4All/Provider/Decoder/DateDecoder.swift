//
//  DateDecoder.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 29/1/22.
//

import Foundation

final class DateDecoder: JSONDecoder {
	
	let dateFormatter = DateFormatter()
	
	override init() {
		super.init()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXX"
		dateDecodingStrategy = .formatted(dateFormatter)
	}
}


