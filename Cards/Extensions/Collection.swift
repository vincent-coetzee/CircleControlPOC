//
//  Collection.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import Foundation

extension Collection
    {
    func detect(_ test:(Self.Element) -> Bool) -> Element?
        {
        for element in self
            {
            if test(element)
                {
                return(element)
                }
            }
        return(nil)
        }
    }
