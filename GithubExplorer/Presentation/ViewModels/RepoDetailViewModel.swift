//
//  RepoDetailViewModel.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

@MainActor
final class RepoDetailViewModel: ObservableObject {
    @Published var repository: Repository?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let getRepoDetailUseCase: GetRepoDetailUseCase

    init(getRepoDetailUseCase: GetRepoDetailUseCase) {
        self.getRepoDetailUseCase = getRepoDetailUseCase
    }
    
    func loadRepository(owner: String, repoName: String) async {
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
        }

        do {
            let repo = try await getRepoDetailUseCase.execute(owner: owner, name: repoName)
            await MainActor.run {
                self.repository = repo
                self.isLoading = false
            }
            print("✅ Loaded repo: \(repo.name)")
        } catch {
            await MainActor.run {
                self.repository = nil
                self.errorMessage = "Failed to load repository: \(error.localizedDescription)"
                self.isLoading = false
            }
            print("❌ Repo load failed: \(error)")
        }
    }

}

