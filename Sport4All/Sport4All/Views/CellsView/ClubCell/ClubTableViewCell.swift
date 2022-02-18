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
		
		// Inicialización Estilos Vista
		homeClubsUIView.layer.cornerCurve = .circular
		homeClubsUIView.layer.cornerRadius = 10
		homeClubsUIView.backgroundColor = .softBlue
		homeClubsUIView.shadow()
		
		self.backgroundColor = .backgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
