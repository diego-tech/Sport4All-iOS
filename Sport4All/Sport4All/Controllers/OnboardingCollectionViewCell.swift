//
//  OnboardingCollectionViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 20/2/22.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
	
	static let identifier = String(describing: OnboardingCollectionViewCell.self)
	
	@IBOutlet weak var slideImageView: UIImageView!
	@IBOutlet weak var slideTitleLbl: UILabel!
	@IBOutlet weak var slideDescriptionLbl: UILabel!
	
	func setUp(_ slide: OnboardingSlide) {
		slideImageView.image = slide.image
		slideTitleLbl.text = slide.title
		slideDescriptionLbl.text = slide.description
	}
}
