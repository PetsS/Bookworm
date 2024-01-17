//
//  DataController.swift
//  Bookworm_project
//
//  Created by Peter Szots on 01/07/2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container  = NSPersistentContainer(name: "Bookworm") //this 'NSPersistentContainer' core data type is responsable of loading a model and give access to the data inside. "Bookworm" is our data model. This doesnt contains the data. It loads data and save it to the device.
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
