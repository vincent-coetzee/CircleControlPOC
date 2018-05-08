//
//  GradientView.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/02.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

@IBDesignable
public class GradientView:UIView
    {
    private var _gradientLayer:CAGradientLayer?
    
    override init(frame:CGRect)
        {
        super.init(frame:frame)
        self.commonInit()
        }
    
    required public init?(coder aDecoder: NSCoder) 
        {
        super.init(coder: aDecoder)
        self.commonInit()
        }
        
    override public func awakeFromNib()
        {
        super.awakeFromNib()
        self.commonInit()
        }
    
    func commonInit()
        {
        let gradientLayer = StylePalette.shared.standardGradientLayer()
        self.layer.addSublayer(gradientLayer)
        gradientLayer.zPosition = -10
        gradientLayer.frame = self.frame
        self.setNeedsDisplay()
        _gradientLayer = gradientLayer
        }
        
    override public func prepareForInterfaceBuilder()
        {
        super.prepareForInterfaceBuilder()
        self.commonInit()
        self.setNeedsLayout()
        self.setNeedsDisplay()
        }
        
    override public func layoutSubviews()
        {
        super.layoutSubviews()
        self._gradientLayer?.frame = self.frame
        }
    }
