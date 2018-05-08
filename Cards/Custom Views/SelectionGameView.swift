//
//  SelectionGameView.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/09.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class SelectionGameView:UIView
    {
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        self.commonInit()
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit()
        {
        let filter = CIFilter(name:"CIGuassianBlur",withInputParameters: [kCIInputRadiusKey: 4])
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor
        self.layer.backgroundColor = UIColor.white.withAlphaComponent(0.2).cgColor
        self.layer.backgroundFilters = [filter]
        }
    }
