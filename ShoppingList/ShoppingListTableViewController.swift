//
//  ShoppingListTableViewController.swift
//  ShoppingList
//
//  Created by Chad Watts on 5/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShoppingListController.sharedController.fetchedResultsController.delegate? = self
        
    }
    
    // MARK: Action button tapped
    
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        presentAlertController()
    }
    
    // Mark: Alert Controller
    
    func presentAlertController () {
        
        var itemTextField: UITextField?
        
        //Create the Alert Controller
        
        let alertController = UIAlertController(title: "Add new Item", message: "New item added", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Item name..."
            itemTextField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let createACtion = UIAlertAction(title: "Add", style: .Default) { (_) in
            guard let title = itemTextField?.text where title.characters.count > 0 else {return}
            ShoppingListController.sharedController.addItem(item)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(createACtion)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        guard let sections = ShoppingListController.sharedController.fetchedResultsController.sections else {return 0}
        return sections.count
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = ShoppingListController.sharedController.fetchedResultsController.sections else {return 0}
        return sections[section].numberOfObjects
    }
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SwitchCell", forIndexPath: indexPath) as?
            SwitchCell ?? SwitchCell()
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = ShoppingListController.sharedController.fetchedResultsController.sections else {return nil}
        let value = Int(sections[section].name)
        
        if value == 0 {
            return "Incomplete"
        } else {
            return "Complete"
        }
        
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            guard let itemList = ShoppingListController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? ShoppingList else { return }
            ShoppingListController.sharedInstance.removeShoppingItem(itemList)
            
            // Delete the row from the table view
            
        }
        
    }
    
}

extension ShoppingListTableViewController: SwitchCellDelegate {
    
    func shoppingItemCellButtonTapped(cell: SwitchCell) {
        guard let indexPath = tableView.indexPathForCell(cell),
            item = ShoppingListController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? ItemList  else {return}
        
        item.isComplete = !item.isComplete.boolValue
        cell.isCompleteValueChanged(item.isComplete.boolValue)
        ShoppingListController.sharedController.saveToPersistentStorage()
        
    }
}

extension ShoppingListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
            
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
            
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
            
        default:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
            
        case .Delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
            
        case .Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
        case .Move:
            guard let indexPath = indexPath, newIndexPath = newIndexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}






