//
//  GroceryApp.swift
//  Grocery
//
//  Created by Apple on 12/08/24.
//

import SwiftUI
import TipKit

@main
struct GroceryApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .task {
                    do {
                        try Tips.configure(
                            [
                            
                            .displayFrequency(.immediate),
                            .datastoreLocation(.applicationDefault)
                        ]
                        )
                        
                    }catch {
                        print("Error Intializing TipKit")
                    }
                }
        }
    }
}
