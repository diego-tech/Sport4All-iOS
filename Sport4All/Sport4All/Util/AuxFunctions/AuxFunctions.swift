//
//  AuxFunctions.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 4/2/22.
//

import Foundation

final class AuxFunctions {
	
	// Comprobar El Status Code que Recibimos del BackEnd
	static func checkStatusCode(statusCode: Int?) -> Bool {
		if statusCode == 0 {
			return false
		} else if (statusCode == 1) {
			return true
		} else {
			return false
		}
	}
}
