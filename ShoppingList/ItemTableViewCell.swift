//
//  ItemTableViewCell.swift
//  ShoppingList
//
//  Created by Chad Watts on 7/8/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    var delegate: ItemButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func checkButtonTapped(sender: AnyObject) {
        
        if let delegate = delegate {
            delegate.itemButtonTapped(self)
        }
    }
    
    func updateItemButton(isComplete: Bool) {
        
        if isComplete {
            
            checkButton.setImage(UIImage(named: "complete"), forState: .Normal)
            
        } else {
            
            checkButton.setImage(UIImage(named: "incomplete"), forState: .Normal)
        }
    }
}

protocol ItemButtonCellDelegate {
    
    func itemButtonTapped(sender: ItemTableViewCell)
}

extension ItemTableViewCell {
    
    func updateWithItem(item: Item) {
        
        itemLabel.text = item.item
        updateItemButton(item.isComplete.boolValue)
    }
}






