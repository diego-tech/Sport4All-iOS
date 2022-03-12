//
//  ReservesDetailTableViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 12/3/22.
//

import UIKit

class ReservesDetailTableViewCell: UITableViewCell {

	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var pricesCollectionView: UICollectionView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		pricesCollectionView.backgroundColor = .red
    }
	
	// MARK: Functions
	
	
	// MARK: Styles

}
