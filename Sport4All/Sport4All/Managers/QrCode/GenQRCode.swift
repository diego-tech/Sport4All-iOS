//
//  GenQRCode.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 1/3/22.
//

import CoreImage.CIFilterBuiltins
import UIKit

final class GenQRCode {
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
