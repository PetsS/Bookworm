//
//  Bookworm_projectApp.swift
//  Bookworm_project
//
//  Created by Peter Szots on 01/07/2022.
//

import SwiftUI

@main
struct Bookworm_projectApp: App {
    @StateObject private var dataController = DataController() //we are going to inject are core data directly into the app environment

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext) //this injects the loaded data into the environment.
        }
    }
}
