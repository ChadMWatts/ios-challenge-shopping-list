//
//  ShoppinglistTableViewController.swift
//  ShoppingList
//
//  Created by Chad Watts on 7/8/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import CoreData
import UIKit

class ShoppinglistTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, ItemButtonCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ShoppinglistController.sharedController.fetchedResultsController.delegate? = self

    }

    @IBAction func addButtonTapped(sender: AnyObject) {
        
        presentAlertController()
    }
    
    func presentAlertController() {
        
        
        
        let alertController = UIAlertController(title: "Add new Item", message: "What else do we need?", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Item name..."
            shoppingItemTextField = textField
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let createACtion = UIAlertAction(title: "Add", style: .Default) { (_) in
            guard let title = shoppingItemTextField?.text where title.characters.count > 0 else {return}
            ShoppinglistController.sharedController.addItem(item)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(createACtion)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        guard let sections = ShoppinglistController.sharedController.fetchedResultsController.sections else {return 0}
        
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let sections = ShoppinglistController.sharedController.fetchedResultsController.sections else {return 0}
        
        return sections[section].numberOfObjects
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
       guard let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as? ItemTableViewCell,
        let item = ShoppinglistController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Item else {return ItemTableViewCell()}
        
        cell.textLabel?.text = item.item
        cell.delegate = self
        
        return cell

    }
  
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
           
            guard let item = ShoppinglistController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Item else {return}
            
            ShoppinglistController.sharedController.removeItem(item)
        }    
    }
    
    // Mark: NSFetchedResultsController
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
            
        case.Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
            
        case.Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
            
        default:
            break
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
            
        case.Insert:
            guard let indexPath = indexPath else {return}
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
        case.Delete:
            guard let indexPath = indexPath else {return}
           tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            
        case.Move:
            guard let newIndexPath  = newIndexPath, indexPath = indexPath else {return}
            tableView.moveRowAtIndexPath(indexPath, toIndexPath: newIndexPath)
            
        case.Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }

    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        
        tableView.endUpdates()
    }
    
    func itemButtonTapped(sender: ItemTableViewCell) {
        
        guard let indexPath = tableView.indexPathForCell(sender),
            item = ShoppinglistController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Item else {return}
        
        ShoppinglistController.sharedController.isCompleteValueToggle(item)
    }
    
}




















