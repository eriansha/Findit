//
//  FinditApp.swift
//  Findit
//
//  Created by Ivan on 20/05/23.
//

import SwiftUI

@main
struct FinditApp: App {
    @StateObject private var finditController = FinditController()
    @StateObject private var errorData = ErrorData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, finditController.persistentContainer.viewContext)
                .environmentObject(errorData)
        }
    }
}
