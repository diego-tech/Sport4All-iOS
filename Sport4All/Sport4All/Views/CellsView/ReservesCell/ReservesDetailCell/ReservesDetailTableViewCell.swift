//
//  ReservesDetailTableViewCell.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 12/3/22.
//

import UIKit

class ReservesDetailTableViewCell: UITableViewCell {

	// MARK: Variables
	var prices = [Price]()
	
	// MARK: Outlets
	@IBOutlet weak var pricesCollectionView: UICollectionView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		// Inicialización Collection View
		pricesCollectionView.backgroundColor = .clear
		pricesCollectionView.dataSource = self
		pricesCollectionView.delegate = self
		pricesCollectionView.isScrollEnabled = true
		pricesCollectionView.register(UINib.init(nibName: "PriceCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PriceCollectionViewCell")
		pricesCollectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
		pricesCollectionView.showsVerticalScrollIndicator = false
		pricesCollectionView.showsHorizontalScrollIndicator = false
		pricesCollectionView.reloadData()
    }
	
	// MARK: Functions
	func setItemWithValueOf(_ prices: [Price]) {
		
	}
	
	// MARK: Styles

}

// MARK: UICollectionView Delegate && Data Source
extension ReservesDetailTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return prices.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PriceCollectionViewCell", for: indexPath) as? PriceCollectionViewCell else {
			return UICollectionViewCell()
		}
		let price = prices[indexPath.row]
		cell.setItemWithValueOf(price)
		return cell
	}
	
	/* Márgenes entre las celdas */
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		let inset = UIEdgeInsets(top: 15, left: 20, bottom: 15, right: 20)
		return inset
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let price = prices[indexPath.row]
		print("Selected Price \(price)")
	}
}
