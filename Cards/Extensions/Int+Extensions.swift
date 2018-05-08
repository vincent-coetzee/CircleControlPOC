//
//  Int+Extensions.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import Foundation

extension Int
    {
    func constrainedTo(minimum:Int,maximum:Int) -> Int
        {
        if self < minimum
            {
            return(minimum)
            }
        else if self > maximum 
            {
            return(maximum)
            }
        return(self)
        }
    }
