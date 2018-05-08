//
//  CAMediaTiming+Extensions.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/02.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import QuartzCore

enum CFTimeIntervalUnit
    {
    case milliseconds(CGFloat)
    case seconds(CGFloat)
    case minutes(CGFloat)
    case hours(CGFloat)
    
    static func now() -> CFTimeInterval
        {
        return(CACurrentMediaTime())
        }
    }
    
extension CFTimeInterval
    {
    static func + (lhs:CFTimeInterval,unit:CFTimeIntervalUnit) -> CFTimeInterval
        {
        switch(unit)
            {
        case(.milliseconds(let amount)):
            return(CFTimeInterval(amount*1000.0)+lhs)
        case(.seconds(let amount)):
            return(CFTimeInterval(amount)+lhs)
        case(.minutes(let amount)):
            return(CFTimeInterval(amount*60)+lhs)
        case(.hours(let amount)):
            return(CFTimeInterval(amount*60*60)+lhs)
            }
        }
    }
