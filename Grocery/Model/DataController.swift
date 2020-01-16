//
//  DataController.swift
//  Grocery
//
//  Created by Takasur Azeem on 16/01/2020.
//  Copyright © 2020 Takasur Azeem. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    let persistanceContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistanceContainer.viewContext
    }
    
    init(modelName: String) {
        persistanceContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistanceContainer.loadPersistentStores { [weak self] (storeDescription, error) in
            guard self != nil else { return }
            if let error = error {
                fatalError(error.localizedDescription)
            }
            completion?()
        }
    }
    
}


extension DataController {
    func autoSaveViewContext(interval: TimeInterval = 30) {
        print("autosaving")
        guard interval > 0 else {
            fatalError("Can not set negative autosave interval")
        }
        if viewContext.hasChanges {
            try? viewContext.save()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + interval) { [weak self] in
            guard let self = self else { return }
            self.autoSaveViewContext(interval: interval)
        }
    }
}
