//
//  GithubExplorerApp.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import SwiftUI
import CoreData

@main
struct GitHubExplorerApp: App {
    let persistenceController = CoreDataStack.shared

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                UserListView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
}

