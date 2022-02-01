//
//  TabBarViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 1/2/22.
//

import UIKit

class TabBarController: UITabBarController {
	
	var customTabBarView = UIView(frame: .zero)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		self.selectedIndex = 1
		
		self.setUpTabBarUI()
		self.addCustomTabBarView()
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		self.setUpCustomTabBarFrame()
	}
	
	// MARK: Styles Methods
	private func setUpCustomTabBarFrame() {
		let height = self.view.safeAreaInsets.bottom + 83
		
		var tabFrame = self.tabBar.frame
		tabFrame.size.height = height
		tabFrame.origin.y = self.view.frame.size.height - height
		
		self.tabBar.frame = tabFrame
		self.tabBar.setNeedsLayout()
		self.tabBar.layoutIfNeeded()
		customTabBarView.frame = tabBar.frame
	}
	
	private func setUpTabBarUI() {
		// Setup Colors
		self.tabBar.tintColor = .corporativeColor
		self.tabBar.unselectedItemTintColor = .softBlue
		
		// Remove the line
		if #available(iOS 13.0, *) {
			let appearance = self.tabBar.standardAppearance
			appearance.shadowImage = nil
			appearance.shadowColor = nil
			appearance.stackedLayoutAppearance.normal.iconColor = .softBlue
			appearance.stackedLayoutAppearance.selected.iconColor = .corporativeColor
			self.tabBar.standardAppearance = appearance
		} else {
			self.tabBar.shadowImage = UIImage()
			self.tabBar.backgroundImage = UIImage()
		}
	}
	
	private func addCustomTabBarView() {
		self.customTabBarView.frame = tabBar.frame
		
		self.customTabBarView.backgroundColor = .white
		self.customTabBarView.layer.borderColor = CGColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
		self.customTabBarView.layer.borderWidth = 1
		self.customTabBarView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		
		self.customTabBarView.layer.masksToBounds = false
		self.customTabBarView.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
		self.customTabBarView.layer.shadowOffset = CGSize(width: -4, height: -6)
		self.customTabBarView.layer.shadowOpacity = 0.2
		self.customTabBarView.layer.shadowRadius = 10
		
		self.view.addSubview(customTabBarView)
		self.view.bringSubviewToFront(self.tabBar)
	}
}
