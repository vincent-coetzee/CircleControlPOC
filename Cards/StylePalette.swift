//
//  StylePalette.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/01.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public class StylePalette
    {
    public static let shared = StylePalette()
    
    public let packBorderColor = UIColor.white
    public let packBorderWidth:CGFloat = 4
    public let packBorderRadius:CGFloat = 6
    public let packCardBackColor = UIColor(red: 0.498,green: 0.459, blue: 0.42, alpha: 1)
    public let packColors:[UIColor] = [UIColor(red:0.392,green: 0.373,blue: 0.349,alpha: 1),UIColor(red:0.529,green:0.439,blue: 0.322,alpha: 1),UIColor(red:0.804,green: 0.478,blue: 0.043,alpha: 1),UIColor(red:0.941,green:0.537,blue:0,alpha:1)]
    public let feltLayerZPosition:CGFloat = 0
    public let bundle:Bundle 
    public let cardBackMask:UIImage 
    
    public var feltColor:UIColor = UIColor(red: 0.667,green: 0.475, blue: 0.224,alpha: 1)
    
    public static func dumpAllFontNames() 
        {
        var fontNames: [String] = []
        for familyName in UIFont.familyNames 
            {
            for fontName in UIFont.fontNames(forFamilyName: familyName) 
                {
                fontNames.append(fontName)
                }
            }
        fontNames = fontNames.sorted()
        for name in fontNames 
            {
            print(name)
            }
        }
    
    init()
        {
        #if TARGET_INTERFACE_BUILDER
            bundle = Bundle.init(for: CardDecksView.self)
            self.cardBackMask = UIImage(named:"CardBackMask.png",in: bundle,compatibleWith:nil)!
        #else
            bundle = Bundle.main
            self.cardBackMask = UIImage(named:"CardBackMask.png",in: bundle,compatibleWith:nil)!
        #endif
        }
//        
//    public var feltColor:UIColor 
//        {
//        guard _feltColor == nil else
//            {
//            return(_feltColor!)
//            }
//        let feltImage = UIImage(named:"OrangeFelt.png",in: bundle,compatibleWith:nil)
//        self._feltColor = UIColor(patternImage: feltImage!)
//        return(self._feltColor!)
//        }
        
    public func feltBackground(inColor overlayColor:UIColor) -> UIColor
        {
        return(overlayColor.colorBlendedWith(fraction:0.75,ofColor:self.feltColor))
        }
        
    public func standardGradientLayer() -> CAGradientLayer
        {
        let startColor = UIColor(unscaledRed: 252.0,green: 85.0,blue: 144.0)
        let endColor = UIColor(unscaledRed: 248.0,green: 102.0,blue: 106.0)
        let layer = CAGradientLayer()
        layer.colors = [startColor.cgColor,endColor.cgColor]
        return(layer)
        }
    }
