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
	
	// Format String to Int
	static func formatTimeToInt(hour: String) -> Int {
		let formatter = DateFormatter()
		formatter.dateFormat = "HH:mm:ss"
		let dateHour = formatter.date(from: hour)
		formatter.dateFormat = "HH"
		
		guard let dateHour = dateHour else { return 0 }

		let onlyHour = formatter.string(from: dateHour)
		
		// Cast String to Int
		guard let onlyHourInt = Int(onlyHour) else { return 0}
		
		return onlyHourInt
	}
	
	// Get Time List
	static func getTimeList(openingTime: Int, closingTime: Int) -> [String] {
		var dateFormatter = DateFormatter()
		let today = Date()
		dateFormatter.dateFormat = "HH"
		let nowTime = dateFormatter.string(from: today)
		let nowTimeInt = Int(nowTime)
		
		var startArrayTime: Int = 0
		
		if String(openingTime) < nowTime {
			startArrayTime = nowTimeInt!
		} else {
			startArrayTime = openingTime
		}
		
		let hoursList: [String] = [
			"01", "02", "03", "04", "05", "06",	"07", "08",	"09", "10", "11", "12",	"13", "14",	"15", "16",	"17", "18", "19", "20", "21", "22", "23", "24"]
		var list: [String] = []
		
		for i in startArrayTime - 1...closingTime - 1 {
			list.append(hoursList[i])
		}
		return list
	}
}
