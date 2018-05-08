//
//  CardGame.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/09.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import Foundation

public protocol CardGame
    {
    var sampleCardIndices:IndexSet { get }
    var title:String { get }
    var details:String { get }
    func cardLabel(at:Int) -> String
    }
