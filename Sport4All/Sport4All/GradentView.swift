//
//  GradentView.swift
//  Sport4All
//
//  Created by Cristobal Lletget Luque on 18/1/22.
//

import Foundation
import UIKit

class GradientView: UIView{

    private var gradientLayer = CAGradientLayer()
    private var vertical: Bool = false
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        gradientLayer.frame = self.bounds
        
        if gradientLayer.sublayers == nil{
            
            gradientLayer.startPoint = CGPoint(x: 0, y:0)
            gradientLayer.endPoint = vertical ? CGPoint(x:0, y:1): CGPoint(x:1, y:0)
            gradientLayer.colors = [UIColor.purple.cgColor, UIColor.cyan.cgColor, UIColor.yellow.cgColor]
            
            gradientLayer.locations = [0.0,0.5,1.0]
            self.layer.insertSublayer(gradientLayer, at: 0)
        
        
        
        }
            
        
    }
    
}
