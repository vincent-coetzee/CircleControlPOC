//
//  CircularBuffer.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/10.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import Foundation

public struct CircularBuffer<Element>:Collection
    {
    public typealias Index = Int
        
    private var elements:[Element] = []
    
    public var count:Int
        {
        return(elements.count)
        }
 
    public var startIndex:Int
        {
        return(elements.startIndex)
        }
        
    public var endIndex:Int
        {
        return(elements.endIndex)
        }
        
    public mutating func append(_ element:Element)
        {
        elements.append(element)
        }
        
    public func decrement(index:Index) -> Index
        {
        let newIndex:Int = index - 1
        guard newIndex >= 0 else
            {
            return(elements.count - 1)
            }
        return(newIndex)
        }
        
    public func decrement(index:Index,by count:Int) -> Index
        {
        var newIndex:Int = index
        for _ in 0..<count
            {
            newIndex = newIndex - 1 < 0 ? elements.count - 1 : newIndex - 1
            }
        return(newIndex)
        }
        
    public func index(after index:Index) -> Index
        {
        return(index + 1)
        } 
        
    public func increment(index:Int) -> Index
        {
        let newIndex:Int = index + 1
        guard newIndex < elements.count else
            {
            return(0)
            }
        return(newIndex)
        }
        
    public func increment(index:Int,by count:Int) -> Index
        {
        var newIndex:Int = index
        for _ in 0..<count
            {
            newIndex = newIndex + 1 >= elements.count ? 0 : newIndex + 1
            }
        return(newIndex)
        }
        
    public subscript(position:Index) -> Element
        {
        if position >= elements.count
            {
            fatalError("Invalid subscript")
            }
        return(elements[position])
        }
        
    public func reversedSlice(from start:Index,count:Int) -> Array<Element>
        {
        var index = start
        var slice:[Element] = []
        repeat
            {
            slice.append(elements[index])
            index = self.decrement(index:index)
            }
        while slice.count < count
        return(slice)
        }
        
    public func slice(from start:Index,count:Int) -> Array<Element>
        {
        var index = start
        var slice:[Element] = []
        repeat
            {
            slice.append(elements[index])
            index = self.increment(index:index)
            }
        while slice.count < count
        return(slice)
        }
    }
