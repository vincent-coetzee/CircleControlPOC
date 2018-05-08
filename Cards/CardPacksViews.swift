//
//  CardPacksViews.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/01.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
public class CardDecksView:UIView
    {
    private var _numberOfPacks:Int = 0
    private var _feltLayer:CALayer = CALayer()
    private var _feltColor:UIColor = UIColor.white
    private var _packs:[VisualCardDeck] = []
    
    @IBInspectable
    public var numberOfPacks:Int
        {
        get
            {
            return(_numberOfPacks)
            }
        set(newNumber)
            {
            let oldNumber = _numberOfPacks
            _numberOfPacks = newNumber
            if _numberOfPacks != oldNumber
                {
                self.resetPacks()
                }
            }
        }
    
    @IBInspectable
    public var feltColor:UIColor
        {
        get
            {
            return(_feltColor)
            }
        set(newFeltColor)
            {
            self._feltColor = newFeltColor
            self.resetView()
            }
        }
        
    private func resetView()
        {
        self._feltLayer.backgroundColor = StylePalette.shared.feltColor.cgColor
        self.setNeedsDisplay()
        }
        
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        self.commonInit()
        }
    
    required public init?(coder aDecoder: NSCoder) 
        {
        super.init(coder:aDecoder)
        self.commonInit()
        }
    
    public override func awakeFromNib()
        {
        self.commonInit()
        super.awakeFromNib()
        }
        
    internal func commonInit()
        {
        self.clipsToBounds = true
        _feltLayer.zPosition = StylePalette.shared.feltLayerZPosition 
        self.layer.addSublayer(_feltLayer)
        self._feltLayer.frame = self.layer.bounds
        }
    
    override public func layoutSubviews()
        {
        super.layoutSubviews()
        self._feltLayer.frame = self.layer.bounds
        self.layoutNewPacks()
        }
        
    private func resetPacks()
        {
        self.removeExistingPacks
            {
            self.layoutNewPacks()
            }
        }
        
    private func removeExistingPacks(_ completion:() -> ())
        {
        for pack in _packs
            {
            pack.vanishCardsAndRemoveFromSuperLayer()
            }
        _packs = []
        }
        
    private func layoutNewPacks()
        {
        let padding = CGSize(width:16,height:16)
        let rectsPerRow = 4.0
        let totalRowPadding = padding.width * CGFloat(rectsPerRow + 1 )
        let rowSpacePerPack = (self.frame.size.width - totalRowPadding) / CGFloat(rectsPerRow)
        let columnSpacePerPack = rowSpacePerPack / 2 * 3
        var offset = CGPoint(x:padding.width,y:padding.height)
        let rectSize = CGSize(width:rowSpacePerPack,height:columnSpacePerPack)
        var colorSet:Set = [0,1,2,3]
        for _ in 0..<self._numberOfPacks
            {
            var randomColorIndex = -1
            repeat
                {
                randomColorIndex = Int(arc4random_uniform(UInt32(4)))
                } 
            while !colorSet.contains(randomColorIndex)
            let packColor = StylePalette.shared.packColors[randomColorIndex]
            colorSet.remove(randomColorIndex)
            if colorSet.count == 0
                {
                colorSet = [0,1,2,3]
                }
            let pack = VisualCardDeck(depth: 12, packSize:  rectSize, tableLayer:  self._feltLayer, startOffset: offset,packColor:packColor)
            _packs.append(pack)
            pack.addToTableLayer()
            offset.x += (padding.width + rectSize.width)
            if offset.x >= self.bounds.size.width
                {
                offset.x = padding.width
                offset.y += padding.height + rectSize.height
                }
            }
        }
        
    override public func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        self.commonInit()
        self.resetView()
        }
    }
