//
//  File.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/01.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

extension CGPoint
    {
    static func += (point:inout CGPoint,offset:CGFloat)
        {
        point.x += offset
        point.y += offset
        }
        
    static func += (point:inout CGPoint,offset:CGSize)
        {
        point.x += offset.width
        point.y += offset.height
        }
        
    static func -= (point:inout CGPoint,offset:CGFloat)
        {
        point.x -= offset
        point.y -= offset
        }
        
    static func += (lhs:inout CGPoint,rhs:(CGFloat,CGFloat))
        {
        lhs.x += rhs.0
        lhs.y += rhs.1
        }
    }
