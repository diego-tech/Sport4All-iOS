//
//  matchListTableViewCell.swift
//  Sport4All
//
//  Created by Cristobal Lletget Luque on 7/3/22.
//

import UIKit

class Section{
    let title: String
    let options: [String]
    var isOpened: Bool = false
    
    init(title: String,
         options: [String],
         isOpened: Bool = false
        ){
        self.title = title
        self.options = options
        self.isOpened = isOpened
    }
}
