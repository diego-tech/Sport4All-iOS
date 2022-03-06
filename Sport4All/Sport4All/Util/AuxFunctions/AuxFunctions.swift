//
//  AuxFunctions.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 4/2/22.
//

import Foundation
import UIKit

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
	
	// Comprobar Servicios que recibo para devolver imagen correspondiente
	static func getServices(clubService: ClubService) -> UIImage {
		switch clubService.name {
		case "Parking":
			return UIImage(systemName: "parkingsign.circle.fill")!
		case "Cafeteria":
			return UIImage(systemName: "fork.knife.circle.fill")!
		case "Enfermeria":
			return UIImage(systemName: "cross.case.fill")!
		case "Tienda":
			return UIImage(systemName: "cart.circle.fill")!
		case "Wifi":
			return UIImage(systemName: "wifi.circle.fill")!
		case "Vestuarios":
			return UIImage(systemName: "tshirt.fill")!
		default:
			return UIImage(systemName: "house.circle.fill")!
		}
	}
}
