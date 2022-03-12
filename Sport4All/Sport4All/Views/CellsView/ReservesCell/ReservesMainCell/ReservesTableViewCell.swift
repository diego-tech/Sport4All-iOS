//
//  ReservesTableViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 12/3/22.
//

import UIKit

class ReservesTableViewCell: UITableViewCell {

	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var courtNameLabel: UILabel!
	@IBOutlet weak var arrowDown: UIImageView!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		// Inicialización de Estilos
		imageViewStyle()
    }
	
	// MARK: Functions
	
	
	// MARK: Styles
	private func imageViewStyle() {
		self.arrowDown.image = UIImage(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 14))
		self.arrowDown.tintColor = .hardColor
	}
}
