//
//  UIStackViewExtension.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 5/3/22.
//

import UIKit

extension UIStackView {
	
	// Get array services and set images in StackView
	func setServicesInStackView(services: [ClubService], imageSize: CGRect) {
		self.arrangedSubviews.forEach { $0.removeFromSuperview() }
		
		var servicesImages = [UIImage()]
		
		for service in services {
			servicesImages.append(AuxFunctions.getServices(clubService: service))
		}
				
		for servicesImage in servicesImages {
			let serviceImageView: UIImageView = {
				let image = UIImageView(frame: imageSize)
				image.contentMode = .scaleToFill
				image.tintColor = .corporativeColor
				return image
			}()
			serviceImageView.image = servicesImage
			self.addArrangedSubview(serviceImageView)
		}
	}
}
