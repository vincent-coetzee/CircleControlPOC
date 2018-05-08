//
//  RingBuffer.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import Foundation

public protocol RingBufferSelection
    {
    
    }
    
public class RingBuffer<Element>:Collection
    {
    private struct ConcreteRingBufferSelection:RingBufferSelection
        {
        var startIndex:Int = 0
        var count:Int = 0
        
        init(start:Int,count:Int)
            {
            self.startIndex = start
            self.count = count
            }
        }
        
    public var elements:[Element] = []
    
    public var startIndex:Int
        {
        return(elements.startIndex)
        }
        
    public var endIndex:Int
        {
        return(elements.endIndex)
        }
        
    public var count:Int
        {
        return(elements.count)
        }
        
    public subscript(position:Int) -> Element
        {
        guard position >= 0 && position < elements.count else
            {
            fatalError("Bad index \(position)")
            }
        return(elements[position])
        }
        
    public func index(after:Int) -> Int
        {
        return(after + 1)
        }
        
    public func selection(at:Int,length:Int) -> RingBufferSelection
        {
        return(ConcreteRingBufferSelection(start:at,count:length))
        }
    }
