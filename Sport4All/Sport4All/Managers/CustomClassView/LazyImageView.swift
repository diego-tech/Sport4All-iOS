//
//  LazyImageViewManager.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 4/3/22.
//

import UIKit

class LazyImageView: UIImageView {
	
	private let imageCache = NSCache<AnyObject, UIImage>()
	
	var blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
	var blurEffectView = UIVisualEffectView()
	
	func loadImage(fromURL imageURL: URL)
	{
		self.setBlurEffect()
		
		if let cachedImage = self.imageCache.object(forKey: imageURL as AnyObject)
		{
			self.image = cachedImage
			return
		}
		
		DispatchQueue.global().async {
			[weak self] in
			
			if let imageData = try? Data(contentsOf: imageURL)
			{
				if let image = UIImage(data: imageData)
				{
					DispatchQueue.main.async {
						self?.setBlurAlpha0Effect()
						self!.imageCache.setObject(image, forKey: imageURL as AnyObject)
						self?.image = image
					}
				}
			}
		}
	}
	
	
	
	// Efecto Blur cuando carguen las imágenes
	func setBlurEffect() {
		blurEffectView.effect = blurEffect
		blurEffectView.frame = self.bounds
		blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		self.addSubview(blurEffectView)
	}
	
	// Efecto Blur Alpha 0
	func setBlurAlpha0Effect() {
		UIView.animate(withDuration: 0.2, delay: 0.2, options: .curveEaseInOut) { [self] in
			self.blurEffectView.alpha = 0
		}
	}
}
