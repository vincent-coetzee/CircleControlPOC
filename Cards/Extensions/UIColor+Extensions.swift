//
//  UIColor+Extensions.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/01.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

extension UIColor 
    {
    func colorBlendedWith(fraction: CGFloat, ofColor color: UIColor) -> UIColor 
        {
        var r1: CGFloat = 1.0, g1: CGFloat = 1.0, b1: CGFloat = 1.0, a1: CGFloat = 1.0
        var r2: CGFloat = 1.0, g2: CGFloat = 1.0, b2: CGFloat = 1.0, a2: CGFloat = 1.0

        self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        return UIColor(red: r1 * (1 - fraction) + r2 * fraction,
            green: g1 * (1 - fraction) + g2 * fraction,
            blue: b1 * (1 - fraction) + b2 * fraction,
            alpha: a1 * (1 - fraction) + a2 * fraction);
        }
        
    convenience init(unscaledRed: CGFloat,green:CGFloat,blue:CGFloat)
        {
        self.init(red:unscaledRed/255.0,green:green/255.0,blue:blue/255.0,alpha:1.0)
        }
    }
