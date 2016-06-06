//
//  SwitchCell.swift
//  ShoppingList
//
//  Created by Chad Watts on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    
    weak var delegate = SwitchCellDelegate?
    
    func updateWithItem(item: Item) {
        
        itemTextField.text = item.item
        isCompleteValueChanged(item.isComplete.boolValue)
        
    }
    
    func isCompleteValueChanged(value: Bool) {
        
        if value == true {
            
            checkButton.imageView?.image = UIImage(named: "Complete")
        } else {
            checkButton.imageView?.image = UIImage(named: "InComplete")
        }
    }
   
}

protocol SwitchCellDelegate: class {
    
    func switchValueChanged(cell: SwitchCell)
}

