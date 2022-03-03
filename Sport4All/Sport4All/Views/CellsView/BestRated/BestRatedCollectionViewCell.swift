//
//  BestRatedCollectionViewCell.swift
//  Sport4All
//
//  Created by Cristobal Lletget Luque on 2/2/22.
//

import UIKit

class BestRatedCollectionViewCell: UICollectionViewCell {
	
	// Variables
	
	// Outlets
	@IBOutlet weak var bestRatedView: UIView!
	@IBOutlet weak var bestRatedIV: UIImageView!
	@IBOutlet weak var bestRatedLabel: UILabel!
	@IBOutlet weak var bestRatedReserveBTN: UIButton!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		uiViewStyles()
		bestRatedReserveBTN.layer.cornerCurve = .circular
		bestRatedReserveBTN.layer.cornerRadius = 5
    }
	
	// MARK: Styles
	private func uiViewStyles() {
		bestRatedView.layer.cornerCurve = .circular
		bestRatedView.layer.cornerRadius = 10
		bestRatedView.backgroundColor = .softBlue
		bestRatedView.shadow(shadowOpacity: 0.15, shadowRadius: 4)
	}
}
