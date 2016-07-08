//
//  ShoppingListController.swift
//  ShoppingList
//
//  Created by Chad Watts on 7/8/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import CoreData
import Foundation

class ShoppinglistController {

    static let sharedController = ShoppinglistController()
    
    let fetchedResultsController: NSFetchedResultsController
    
    init() {
        
        let request = NSFetchRequest(entityName: "Item")
        let sortDiscriptor = NSSortDescriptor(key: "isComplete", ascending: false)
        request.sortDescriptors = [sortDiscriptor]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
        _ = try? fetchedResultsController.performFetch()
    }
    
    func addItem(item: String) {
        
        _ = Item(item: item)
        saveToPersistantStorage()
    }
    
    func removeItem(item: Item) {
        
        item.managedObjectContext?.deleteObject(item)
        saveToPersistantStorage()
    }
    
    func isCompleteValueToggle(item: Item) {
        item.isComplete = !item.isComplete.boolValue
        saveToPersistantStorage()
    }
    
    func saveToPersistantStorage() {
        
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Error saving! Item not saved!")
        }
    }

}





