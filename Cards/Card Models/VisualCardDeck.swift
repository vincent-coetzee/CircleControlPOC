//
//  File.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/01.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
internal class VisualCardDeck
    {
    private var depth:Int
    private let packSize:CGSize
    private var cards:[CALayer] = []
    private let tableLayer:CALayer 
    private let startOffset:CGPoint
    private let packColor:UIColor
    
    init(depth:Int,packSize:CGSize,tableLayer:CALayer,startOffset:CGPoint,packColor:UIColor)
        {
        self.depth = depth
        self.packSize = packSize
        self.tableLayer = tableLayer
        self.startOffset = startOffset
        self.packColor = packColor
        }
        
    @IBInspectable var packDepth:Int
        {
        get
            {
            return(self.depth)
            }
        set(newDepth)
            {
            #if TARGET_INTERFACE_BUILDER
            self.vanishCardsAndRemoveFromSuperLayer()
            self.addToTableLayer()
            #endif
            }
        }
        
    func addToTableLayer()
        {
        var offset = startOffset
        var zPosition:CGFloat = 1
        let imageMask = StylePalette.shared.cardBackMask.resizedTo(size:packSize)
        for _ in 0..<depth
            {
            let newCard = self.createCard(imageMask:imageMask)
            newCard.frame = CGRect(origin:offset,size:packSize)
            newCard.zPosition = zPosition
            zPosition += 1
            cards.append(newCard)
            tableLayer.addSublayer(newCard)
            offset -= 0.25
            }
        }
        
    func vanishCardsAndRemoveFromSuperLayer()
        {
        let animationBaseTime = CFTimeIntervalUnit.now()
        let animationOffsetInterval = CFTimeIntervalUnit.milliseconds(200)
        var animationOffset:CFTimeInterval = 0
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setCompletionBlock
            {
            () -> () in 
            self.packCardsAway()
            }
        for card in cards 
            {
            let vanishAnimation = CABasicAnimation()
            vanishAnimation.duration = 0.45
            vanishAnimation.fromValue = card.zPosition
            vanishAnimation.toValue = -1
            vanishAnimation.beginTime = animationBaseTime
            vanishAnimation.timeOffset = animationOffset
            animationOffset = animationOffset + animationOffsetInterval
            card.add(vanishAnimation,forKey:nil)
            }
        CATransaction.commit()
        }
        
    private func createCard(imageMask:UIImage) -> CALayer
        {
        let newCard = CALayer()
        let maskLayer = CALayer()
//            newCard.mask = maskLayer
        maskLayer.contents = imageMask
        maskLayer.frame = newCard.frame.insetBy(dx: StylePalette.shared.packBorderWidth, dy: StylePalette.shared.packBorderWidth)
        newCard.backgroundColor = self.packColor.cgColor
        newCard.borderWidth = 0.75
        newCard.borderColor = UIColor.black.cgColor
        newCard.cornerRadius = StylePalette.shared.packBorderRadius
        let innerLayer = CALayer()
        innerLayer.borderWidth = StylePalette.shared.packBorderWidth
        innerLayer.borderColor = StylePalette.shared.packBorderColor.cgColor
        newCard.addSublayer(innerLayer)
        innerLayer.frame = newCard.frame.insetBy(dx:1,dy:1)
        return(newCard)
        }
        
        
    func packCardsAway()
        {
        }
        
    func prepareForInterfaceBuilder()
        {
        }
        
    
    }
