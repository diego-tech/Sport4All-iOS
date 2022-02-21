//
//  UISegmentedControlExtension.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 8/2/22.
//

import UIKit

var segmentedSetUp = false
var underlineSegmented = UIView()
var underlineAll = UIView()

extension UISegmentedControl {
	func setUpView() {
		if segmentedSetUp == false {
			segmentedSetUp = true
			self.addSubview(underlineSegmented)
			self.addSubview(underlineAll)
			removeBorder()
		}
		
		addAllUnderline()
		addUnderlineForSelectedSegment()
	}
	
	func removeBorder() {
		let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.clear.cgColor, andSize: self.bounds.size)
		self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
		self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
		self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
		
		let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.clear.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
		self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
		self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blueLowOpacity!], for: .normal)
		self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.hardColor!], for: .selected)
	}
	

	func addUnderlineForSelectedSegment() {
		let underlineWidth: CGFloat = self.frame.size.width / CGFloat(numberOfSegments)
		let underlineHeight: CGFloat = 2.0
		let underLineYPosition = self.bounds.size.height - 1.0
		let underlineFrame = CGRect(x: 0, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
		
		underlineSegmented.frame = underlineFrame
		underlineSegmented.backgroundColor = UIColor.hardColor
		underlineSegmented.tag = 1
	}
	
	func addAllUnderline() {
		let underlineWidth: CGFloat = self.frame.size.width
		let underlineHeight: CGFloat = 2.0
		let underLineYPosition = self.bounds.size.height - 1.0
		let underlineFrame = CGRect(x: 0, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
		
		underlineAll.frame = underlineFrame
		underlineAll.backgroundColor = UIColor.blueLowOpacity
	}
	
	func changeUnderlinePosition() {
		guard let underline = self.viewWithTag(1) else { return }
		let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
		
		UIView.animate(withDuration: 0.1, animations: {
			underline.frame.origin.x = underlineFinalXPosition
		})
	}
}


extension UIImage {
	class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage {
		UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
		let graphicsContext = UIGraphicsGetCurrentContext()
		graphicsContext?.setFillColor(color)
		let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
		graphicsContext?.fill(rectangle)
		let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return rectangleImage!
	}
}
