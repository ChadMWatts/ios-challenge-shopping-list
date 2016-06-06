//
//  ShoppingListController.swift
//  ShoppingList
//
//  Created by Chad Watts on 5/27/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class ShoppingListController {
    
    static let sharedController = ShoppingListController()
    var fetchedResultsController = NSFetchedResultsController()
    
    init() {
        
        let request = NSFetchRequest(entityName: "Item")
        let sortDiscriptor1 = NSSortDescriptor(key: "isComplete", ascending: false)
        
        request.sortDescriptors = [sortDiscriptor1]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        _ = try? fetchedResultsController.performFetch()
        
    }
    
    func addItem(item: String) {
        
        _ = ItemList(item: item)
        saveToPersistentStorage()
    }
    
    func removeItem() {
        
        let moc = Stack.sharedStack.managedObjectContext
        moc.deletedObjects(ItemList)
        saveToPersistentStorage()
    }
    
    func saveToPersistentStorage() {
        
        let moc = Stack.sharedStack.managedObjectContext
        
        do {
            try moc.save()
        }catch{
            print("There was a problem saving Managed Object Context")
        }
    }
}



























