//
//  ShadowView.swift
//  Remind
//
//  Created by SD on 30/10/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
        layer.cornerRadius = 5
    }

}
