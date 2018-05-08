//
//  CircularSelectionView.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/09.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

public class ItemLayer:CALayer
    {
    public var contentLayer = CATextLayer()
    public var isDisplayed = false
    public var contentRect = CGRect.zero
    
    override init()
        {
        super.init()
        contentLayer.backgroundColor = UIColor.white.withAlphaComponent(0.8).cgColor
        contentLayer.borderWidth = 2
        contentLayer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        contentLayer.foregroundColor = UIColor.black.cgColor
        contentLayer.fontSize = 20
        contentLayer.alignmentMode = "center"
        contentLayer.cornerRadius = 6
        self.addSublayer(contentLayer)
        self.masksToBounds = true
        }
    
    override public func layoutSublayers()
        {
        super.layoutSublayers()
        self.contentLayer.frame = self.contentRect
        }
        
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
    
public class CircularSelectionView:UIView
    {
    private let AnimationDuration:CFTimeInterval = 0.3
    
    private var items:CircularBuffer<ItemLayer> = CircularBuffer()
    private var currentIndex:Int = 7
    private let containerLayer = CALayer()
    private var topIndex = 0
    private var bottomIndex = 0
    private var rotationAngle:CGFloat = CGFloat.pi/4.0
    private var contentInset:CGFloat = 8
    private var contentRect = CGRect.zero
    private var maximumTopOffset:CGFloat = 0
    
    public var numberOfVisibleItems:Int = 7
        {
        didSet
            {
            if self.numberOfVisibleItems % 2 != 1
                {
                fatalError("numberOfVisibleItems must be an odd number")
                }
            rotationAngle = CGFloat.pi / CGFloat(self.numberOfVisibleItems - 1)
            self.setNeedsLayout()
            }
        }
    override public func awakeFromNib()
        {
        super.awakeFromNib()
        rotationAngle = CGFloat.pi / CGFloat(self.numberOfVisibleItems - 1)
        self.commonInit()
        for index in 0..<20
            {
            let item = ItemLayer()
            item.contentLayer.string = "\(index)"
            items.append(item)
            self.containerLayer.addSublayer(item)
            item.frame = CGRect.zero
            }
        topIndex = 0
        bottomIndex = self.numberOfVisibleItems - 1
        self.setNeedsLayout()
        }
    
    private func commonInit()
        {
        self.layer.addSublayer(containerLayer)
        var recognizer:UIGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(CircularSelectionView.onSwipeDown))
        (recognizer as! UISwipeGestureRecognizer).direction = [.down]
        self.addGestureRecognizer(recognizer)
        recognizer = UISwipeGestureRecognizer(target: self, action: #selector(CircularSelectionView.onSwipeUp))
       (recognizer as! UISwipeGestureRecognizer).direction = [.up]
        self.addGestureRecognizer(recognizer)
        recognizer = UITapGestureRecognizer(target: self, action: #selector(CircularSelectionView.onTap(_:)))
        self.addGestureRecognizer(recognizer)
        }
        
    @objc public func onTap(_ recognizer:UITapGestureRecognizer)
        {
        let location = recognizer.location(in: self)
        let myBounds = self.bounds
//        if let tappedItem = items.detect({$0.hitTest(location) != nil})
//            {
//            self.rotateToItem(tappedItem)
//            self.selectItem(tappedItem)
//            }
//        else 
        if location.y < myBounds.size.height / 2
            {
            self.swipeUp()
            }
        else
            {
            self.swipeDown()
            }
        }
        
    private func rotateToItem(_ item:ItemLayer)
        {
//        guard let tappedIndex = items.index(of:item) else
//            {
//            return
//            }
//        let selectedIndex = (self.numberOfVisibleItems - 1)/2
//        let delta = tappedIndex - selectedIndex
//        if delta > 0
//            {
//            self.swipeUp(by:delta)
//            }
//        else
//            {
//            self.swipeDown(by:abs(delta))
//            }
        }
        
    private func selectItem(_ item:ItemLayer)
        {
        }
        
    @objc public func onSwipeDown()
        {
        self.swipeDown()
        }
        
    private func swipeDown()
        {
        let targetTopIndex = items.decrement(index:topIndex)
        let targetBottomIndex = items.decrement(index:bottomIndex)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setAnimationDuration(AnimationDuration)
        CATransaction.setValue(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),forKey:kCATransactionAnimationTimingFunction)
        if !items[targetTopIndex].isDisplayed
            {
            items[targetTopIndex].transform = CATransform3DMakeRotation(self.rotationAngle,0,0,1)
            }
        for item in items.slice(from:targetTopIndex,count:self.numberOfVisibleItems + 1)
            {
            let animation = CABasicAnimation(keyPath: "transform.rotation.z")
            let fromValue = item.value(forKeyPath: "transform.rotation.z") as! CGFloat
            let toValue = fromValue - self.rotationAngle
            animation.fromValue = fromValue
            animation.toValue = toValue
            animation.isRemovedOnCompletion = true
            item.add(animation, forKey: nil)
            item.setValue(toValue,forKeyPath:"transform.rotation.z")
            }
        CATransaction.commit()
        items[bottomIndex].isDisplayed = false
        items[topIndex].isDisplayed = true
        topIndex = targetTopIndex
        bottomIndex = targetBottomIndex
        }
        
    @objc public func onSwipeUp()
        {
        self.swipeUp()
        }
        
    private func swipeUp()
        {
        let targetTopIndex = items.increment(index:topIndex)
        let targetBottomIndex = items.increment(index:bottomIndex)
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        CATransaction.setAnimationDuration(AnimationDuration)
        CATransaction.setValue(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),forKey:kCATransactionAnimationTimingFunction)
        if !items[targetBottomIndex].isDisplayed
            {
            items[targetBottomIndex].transform = CATransform3DMakeRotation(CGFloat.pi - self.rotationAngle,0,0,1)
            }
        for item in items.reversedSlice(from:targetBottomIndex,count:self.numberOfVisibleItems + 1)
            {
            let animation = CABasicAnimation(keyPath: "transform.rotation.z")
            let fromValue = item.value(forKeyPath: "transform.rotation.z") as! CGFloat
            let toValue = fromValue + self.rotationAngle
            animation.fromValue = fromValue
            animation.toValue = toValue
            animation.isRemovedOnCompletion = true
            item.add(animation, forKey: nil)
            item.setValue(toValue,forKeyPath:"transform.rotation.z")
            }
        CATransaction.commit()
        items[bottomIndex].isDisplayed = true
        items[topIndex].isDisplayed = false
        topIndex = targetTopIndex
        bottomIndex = targetBottomIndex
        }
        
    private func calculateSizes()
        {
        let myBounds = self.bounds
        let minSpan = min(myBounds.size.width,myBounds.size.height)
        let itemWidth = myBounds.size.height / CGFloat(self.numberOfVisibleItems)
        let itemHeight = min(min(itemWidth * 3.0 / 2.0,itemWidth),minSpan)
        self.contentRect = CGRect(origin:CGPoint(x:0,y:0),size:CGSize(width:itemWidth,height:itemHeight)).insetBy(dx: contentInset, dy: contentInset)
        }
        
    override public func layoutSubviews()
        {
        super.layoutSubviews()
        self.calculateSizes()
        let myBounds = self.bounds
        containerLayer.frame = myBounds
        let itemWidth = contentRect.size.width + 2.0*self.contentInset
        let itemHeight = min(myBounds.size.width,myBounds.size.height/2.0)
        let yOffset = (myBounds.size.height/2.0) - max(itemWidth,itemHeight)
        var rotation = CGFloat(0)
        let frame = CGRect(x:myBounds.size.width - itemWidth/2.0,y:yOffset,width:itemWidth,height:myBounds.size.height-2*yOffset)
        for item in items
            {
            item.transform = CATransform3DIdentity
            item.contentRect = self.contentRect
            item.frame = frame
            item.transform = CATransform3DMakeRotation(self.rotationAngle,0,0,1)
            item.needsLayout()
            }
        for item in items.slice(from:topIndex,count:self.numberOfVisibleItems + 1)
            {
            item.isDisplayed = true
            item.transform = CATransform3DIdentity
            item.frame = frame
            item.transform = CATransform3DMakeRotation(rotation,0,0,1)
            rotation -= self.rotationAngle
            }
        }
    }
