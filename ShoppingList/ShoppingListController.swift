//
//  ShoppingListController.swift
//  ShoppingList
//
//  Created by Chad Watts on 5/20/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

import CoreData

class ShoppingListController {
    
    static let sharedContoller = ShoppingListController()
    
    var shoppingList: [ShoppingList] = []
    
    var completedList: [ShoppingList] {
        
        let request = NSFetchRequest(entityName: "ShoppingList")
        let moc = Stack.sharedStack.managedObjectContext
        let shoppingLists = (try? moc.executeFetchRequest(request)) as? [ShoppingList] ?? []
        return shoppingLists.filter({$0.isComplete == true})
    }
    
    var inCompletedList: [ShoppingList] {
        
        let request = NSFetchRequest(entityName: "ShoppingList")
        let moc = Stack.sharedStack.managedObjectContext
        let shoppingLists = (try? moc.executeFetchRequest(request)) as? [ShoppingList] ?? []
        return shoppingLists.filter({$0.isComplete == false})
    }
    
    func addShoppinList(name: String) {
        let _ = ShoppingList(name: name)
        
    }
    
    func updateShoppingList(shoppinglist: ShoppingList, name: String) {
        
        shoppingList.name = name
        
    }
    
    func removeShoppingList(shoppingList: ShoppingList) {
        
        shoppingList.managedObjectContext?.deleteObject(shoppingList)
    }
    
    func isComplete(ShoppingList: ShoppingList) {
        
        shoppingList.isComplete = !shoppingList.isComplete.boolValue
        
    }
    
    func saveToPersistentStorage() {
        
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Error saving managed objects. Items not saved")
        }
    }
}


