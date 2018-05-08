//
//  ViewController.swift
//  Cards
//
//  Created by Vincent Coetzee on 2018/04/01.
//  Copyright © 2018 MacSemantics. All rights reserved.
//

import UIKit

class ViewController: UIViewController 
    {
    @IBOutlet public var cardDeckCollectionView:UICollectionView!
    
    private var containerCellWidth:CGFloat = 0
    
    override func viewDidLoad() 
        {
        super.viewDidLoad()
        for name in CIFilter.filterNames(inCategory: kCICategoryBlur)
            {
            print(name)
            }
        }

    override func didReceiveMemoryWarning()     
        {
        super.didReceiveMemoryWarning()
        }
        
    override func awakeFromNib()
        {
        super.awakeFromNib()
        let screenWidth = UIScreen.main.bounds.size.width
        containerCellWidth = screenWidth - 2*20
        }
    }

extension ViewController:UICollectionViewDataSource
    {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
        {
        return(10)
        }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
        {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CardDeckCell.self), for: indexPath) as! CardDeckCell
        return(cell)
        }
        
    public func numberOfSections(in collectionView: UICollectionView) -> Int
        {
        return(1)
        }
    }
    
extension ViewController:UICollectionViewDelegate
    {
    public func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize 
        {           
        return(CGSize(width:containerCellWidth,height:100))
        }
    }
