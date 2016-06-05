//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Chad Watts on 5/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController, SwitchCellDelegate {
    
    var item: [Item] = []
    


    override func viewDidLoad() {
        super.viewDidLoad()

      // let completedItem = ShoppingListController.sharedController.completedItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    @IBAction func checkButtonTapped(sender: AnyObject) {
        
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as?
        SwitchCell ?? SwitchCell()
        
      
        return cell
    }


}

func updateWithItem(item: Item) {
    
}

func switchValueChanged(cell: SwitchCell) {
    
    guard let indexPath = tableView.indexPathForCell(cell) else {return}
}



