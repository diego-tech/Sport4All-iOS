//
//  UsersMatchCollectionViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 19/3/22.
//

import UIKit

class UsersMatchCollectionViewCell: UICollectionViewCell {
	
	// MARK: Variables
	
	// MARK: Outlets
	@IBOutlet weak var collectionViewUserImageView: LazyImageView!
	
	// MARK: Functions
	func setItemWithValueOf(_ user: User) {
		print(user)
		updateUI(userImageView: user.image)
	}
	
	private func updateUI(userImageView: String?) {
		if let userImageView = userImageView {
			guard let userImageUrl = URL(string: Constants.kStorageURL + userImageView) else { return }
			self.collectionViewUserImageView.loadImage(fromURL: userImageUrl)
		} else {
			self.collectionViewUserImageView.image = UIImage(named: "Avatar")
		}
		
		self.collectionViewUserImageView.makeRounds()
	}
}
