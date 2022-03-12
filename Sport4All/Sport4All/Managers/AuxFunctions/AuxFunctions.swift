//
//  AuxFunctions.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 4/2/22.
//

import Foundation
import UIKit
import CoreImage.CIFilterBuiltins

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
		case Constants.parking:
			return UIImage(systemName: "parkingsign.circle.fill")!
		case Constants.coffeeShop:
			return UIImage(systemName: "fork.knife.circle.fill")!
		case Constants.nursing:
			return UIImage(systemName: "cross.case.fill")!
		case Constants.shop:
			return UIImage(systemName: "cart.circle.fill")!
		case Constants.internet:
			return UIImage(systemName: "wifi.circle.fill")!
		case Constants.changingRooms:
			return UIImage(systemName: "tshirt.fill")!
		default:
			return UIImage(systemName: "house.circle.fill")!
		}
	}
	
	// Generate QR Code Image
	static func generateQRCodeImage(reservationCode: String) -> UIImage {
		let context = CIContext()
		let filter = CIFilter.qrCodeGenerator()
		let data = Data(reservationCode.utf8)
		filter.setValue(data, forKey: "inputMessage")
		
		if let qrCodeImage = filter.outputImage {
			if let qrCodeCgImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent) {
				return UIImage(cgImage: qrCodeCgImage)
			}
		}
		return UIImage(systemName: "xmark.circle.fill") ?? UIImage()
	}
}
