//
//  CGRect+Extensions.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/02.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

extension CGRect
    {
    // Return a tuple with rows, columns and array columns row arrays of columns
    func divideIntoRects(count:Int) -> (rows:Int,columns:Int,rects:[[CGRect]],newPadding:CGSize)
        {
        let padding = CGSize(width:8,height:8)
        let rectsPerRow = 4.0
        let totalRowPadding = padding.width * CGFloat(rectsPerRow + 1 )
        let rowSpacePerPack = (self.size.width - totalRowPadding) / CGFloat(rectsPerRow)
        let columnSpace = rowSpacePerPack / 2 * 3
        
        let sizeWithPadding = size + padding
        let columns = Int(self.size.width / sizeWithPadding.width)
        let rows = Int(self.size.height / sizeWithPadding.height)
        let columnPadding = (self.size.width - CGFloat(columns)*size.width)/(CGFloat(columns) + 1)
        let rowPadding = (self.size.height - CGFloat(rows)*size.height)/(CGFloat(rows) + 1)
        let newPadding = CGSize(width:columnPadding,height:rowPadding)
        var offset:CGPoint = CGPoint(x:columnPadding,y:rowPadding)
        var rects:[[CGRect]] = []
        
        for _ in 0..<rows
            {
            var columnRects:[CGRect] = []
            for _ in 0..<columns
                {
                columnRects.append(CGRect(origin: origin,size:size))
                offset += (columnPadding,0)
                }
            offset.x = columnPadding
            offset.y += rowPadding
            rects.append(columnRects)
            }
        return((rows:rows,columns:columns,rects:rects,newPadding:newPadding))
        }
    }
