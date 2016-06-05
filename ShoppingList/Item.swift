//
//  Item.swift
//  ShoppingList
//
//  Created by Chad Watts on 6/3/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class Item: NSManagedObject {
        
        convenience init?(item: String, isComplete: Bool, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
            
            guard let entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: context) else
            {return nil}
            
            self.init(entity: entity, insertIntoManagedObjectContext: context) {
                
                self.item = item
                self.isComplete = isComplete
            }
        }
        
    }



