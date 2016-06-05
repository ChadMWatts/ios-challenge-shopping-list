//
//  SwitchCell.swift
//  ShoppingList
//
//  Created by Chad Watts on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    weak var delegate = SwitchCellDelegate?()
    
    func updateWithItem(item: Item) {
        
        itemLabel.text = Item.name
        checkButton.on = Item.isComplete
        
    }
   
}

protocol SwitchCellDelegate: class {
    
    func switchValueChanged(cell: SwitchCell)
}

