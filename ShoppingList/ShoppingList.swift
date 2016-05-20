//
//  ShoppingList.swift
//  ShoppingList
//
//  Created by Chad Watts on 5/20/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

@objc(ShoppingList)
class ShoppingList: NSManagedObject {
    
    // Insert code here to add functionality to your managed object subclass
    
    convenience init?(name: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("ShoppingList", inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        self.isComplete = false
    }
}
