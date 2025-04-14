//
//  UserLocalDataSource.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation
import CoreData

final class UserLocalDataSource {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataStack.shared.container.viewContext) {
        self.context = context
    }

    func save(users: [User]) {
        users.forEach { user in
            let entity = UserEntity(context: context)
            entity.id = Int64(user.id)
            entity.username = user.username
            entity.avatarURL = user.avatarURL.absoluteString
        }

        do {
            try context.save()
        } catch {
            print("Failed to save users: \(error)")
        }
    }

    func fetchAll() -> [User] {
        let request: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            return try context.fetch(request).map { entity in
                User(
                    id: Int(entity.id),
                    username: entity.username ?? "",
                    avatarURL: URL(string: entity.avatarURL ?? "") ?? URL(string: "https://github.com")!
                )
            }
        } catch {
            print("Failed to fetch users: \(error)")
            return []
        }
    }
}

