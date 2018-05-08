//
//  GameSelectionView.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/09.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class GameSelectionView:UIView
    {
    private var gameViews:[SelectionGameView] = []
    private var currentIndex:Int = 0
    
    override func awakeFromNib()
        {
        super.awakeFromNib()
        for _ in 0..<20
            {
            let subView = SelectionGameView(frame: CGRect.zero)
            subView.layer.zPosition = 0
            gameViews.append(subView)
            self.addSubview(subView)
            }
        currentIndex = gameViews.count / 2
        }
        
    override func layoutSubviews()
        {
        super.layoutSubviews()
        self.layoutCurrentlySelectedView()
        self.layoutOtherViews()
        }
        
    private func layoutCurrentlySelectedView()
        {
        let subView = gameViews[currentIndex]
        subView.layer.zPosition = 20
        subView.frame = self.bounds.insetBy(dx: 80, dy: 0)
        }
        
    private func layoutOtherViews()
        {
        var index = currentIndex - 1
        var frame = gameViews[currentIndex].frame
        frame.size.height -= 30
        frame.size.width -= 30
        frame.origin.y += 15
        frame.origin.x += 40
        frame.origin.x -= frame.size.width
        while index >= 0
            {
            gameViews[index].frame = frame
            gameViews[index].layer.zPosition = 0
            frame.origin.x -= ( 20 + frame.size.width)
            index -= 1
            }
        }
    }
