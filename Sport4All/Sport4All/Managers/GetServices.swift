//
//  GetServices.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 3/3/22.
//

import Foundation
import UIKit

final class GetServices {
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
