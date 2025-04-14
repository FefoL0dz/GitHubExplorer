//
//  RepoLocalDataSource.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation
import CoreData

final class RepoLocalDataSource {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = CoreDataStack.shared.container.viewContext) {
        self.context = context
    }

    func save(repositories: [Repository]) {
        repositories.forEach { repo in
            let entity = RepositoryEntity(context: self.context)
            entity.id = Int64(repo.id)
            entity.name = repo.name
            entity.repoDescription = repo.description
            entity.primaryLanguage = repo.primaryLanguage
            entity.stars = Int64(repo.stars)
            entity.forks = Int64(repo.forks)
            entity.openIssues = Int64(repo.openIssues)
            entity.isPrivate = repo.isPrivate
            entity.isArchived = repo.isArchived
            entity.lastUpdated = repo.lastUpdated
            entity.htmlURL = repo.htmlURL
        }

        do {
            try context.save()
        } catch {
            print("Failed to save repositories: \(error)")
        }
    }

    func fetchAll() -> [Repository] {
        let request: NSFetchRequest<RepositoryEntity> = RepositoryEntity.fetchRequest()
        do {
            return try context.fetch(request).map { entity in
                Repository(
                    id: Int(entity.id),
                    name: entity.name ?? "",
                    description: entity.repoDescription,
                    primaryLanguage: entity.primaryLanguage,
                    stars: Int(entity.stars),
                    forks: Int(entity.forks),
                    openIssues: Int(entity.openIssues),
                    isPrivate: entity.isPrivate,
                    isArchived: entity.isArchived,
                    lastUpdated: entity.lastUpdated ?? Date(),
                    htmlURL: entity.htmlURL ?? URL(string: "https://github.com")!
                )
            }
        } catch {
            print("Failed to fetch repositories: \(error)")
            return []
        }
    }
}

