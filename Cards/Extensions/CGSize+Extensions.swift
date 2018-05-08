//
//  CGSize.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/02.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

extension CGSize
    {
    static func += (lhs: inout CGSize,rhs:CGSize)
        {
        lhs.width += rhs.width
        lhs.height += rhs.height
        }
        
    static func + (lhs:CGSize,rhs:CGSize) -> CGSize
        {
        var newSize = lhs
        
        newSize.width += rhs.width
        newSize.height += rhs.height
        return(newSize)
        }
    }
