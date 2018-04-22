//
//  DataController.swift
//  VirtualTourist
//
//  Created by Felipe Valdivia on 4/22/18.
//  Copyright © 2018 Felipe Valdivia. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    let persistandContainer:NSPersistentContainer
    
    var viewContext:NSManagedObjectContext {
        return persistandContainer.viewContext
    }
    
    init(modelName:String) {
        persistandContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completition: (() -> Void)? = nil) {
        persistandContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completition?()
        }
    }
}
