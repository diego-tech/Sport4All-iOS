//
//  ClubTableViewCell.swift
//  Sport4All
//
//  Created by Javier González Delmas on 8/2/22.
//

import UIKit

class ClubTableViewCell: UITableViewCell {

	// Variables

	// Outlets
	@IBOutlet weak var homeClubsUIView: UIView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		homeClubsUIView.layer.cornerCurve = .circular
		homeClubsUIView.layer.cornerRadius = 10
		self.backgroundColor = .backgroundColor
		self.contentView.backgroundColor = .softBlue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
//		self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
	}
}
