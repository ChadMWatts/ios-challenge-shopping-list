//
//  Item.swift
//  ShoppingList
//
//  Created by Chad Watts on 6/8/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class Itemlist: NSManagedObject {
        
        convenience init?(item: String, isComplete: Bool, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
            
            guard let entity = NSEntityDescription.entityForName("itemlist", inManagedObjectContext: context) else
            {return nil}
            
                self.init(entity: entity, insertIntoManagedObjectContext: context)
                self.item = item
                self.isComplete = isComplete
            }
        }
        




