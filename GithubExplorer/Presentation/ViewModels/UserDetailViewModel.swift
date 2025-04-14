//
//  UserDetailViewModel.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

@MainActor
final class UserDetailViewModel: ObservableObject {
    @Published var profile: UserProfile?
    @Published var repositories: [Repository] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let getUserProfileUseCase: GetUserProfileUseCase
    private let getUserReposUseCase: GetUserReposUseCase

    init(
        getUserProfileUseCase: GetUserProfileUseCase,
        getUserReposUseCase: GetUserReposUseCase
    ) {
        self.getUserProfileUseCase = getUserProfileUseCase
        self.getUserReposUseCase = getUserReposUseCase
    }

    func fetchDetails(username: String) async {
        isLoading = true
        errorMessage = nil

        async let profileTask = getUserProfileUseCase.execute(username: username)
        async let reposTask = getUserReposUseCase.execute(username: username)

        do {
            let (profile, repos) = try await (profileTask, reposTask)
            self.profile = profile
            self.repositories = repos
        } catch {
            errorMessage = "Failed to load user details: \(error.localizedDescription)"
        }

        isLoading = false
    }
}

