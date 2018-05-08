//
//  CardDeckCell.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/02.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public class CardDeckCell:UICollectionViewCell
    {
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        self.commonInit()
        }
    
    required public init?(coder aDecoder: NSCoder) 
        {
        super.init(coder: aDecoder)
        self.commonInit()
        }
        
    func commonInit()
        {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.cgColor
        self.translatesAutoresizingMaskIntoConstraints = false
        }
}
