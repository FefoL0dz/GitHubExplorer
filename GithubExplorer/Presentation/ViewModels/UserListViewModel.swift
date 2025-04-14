//
//  UserListViewModel.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Combine
import Foundation

@MainActor
final class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: IdentifiableError?
    @Published var searchQuery: String = ""
    let debouncedQuery = DebouncedPublisher(initialValue: "")

    private var currentPage = 1
    private var hasMore = true
    private var cancellables = Set<AnyCancellable>()

    private let getUserListUseCase: GetUserListUseCase
    private let searchUsersUseCase: SearchUsersUseCase

    init(
        getUserListUseCase: GetUserListUseCase,
        searchUsersUseCase: SearchUsersUseCase
    ) {
        self.getUserListUseCase = getUserListUseCase
        self.searchUsersUseCase = searchUsersUseCase
        
        debouncedQuery.setup(
            source: $searchQuery.eraseToAnyPublisher(),
            delay: 0.5,
            mode: .debounce,
            removeDuplicates: true
        )

        bindDebouncedSearch()
    }

    private func bindDebouncedSearch() {
        debouncedQuery.$value
            .receive(on: DispatchQueue.main)
            .sink { [weak self] query in
                guard let self else { return }
                Task {
                    if query.isEmpty {
                        await self.refreshUsers()
                    } else {
                        await self.searchUsers(query: query)
                    }
                }
            }
            .store(in: &cancellables)
    }


    func loadMoreUsers() async {
        print("🔁 Fetching page \(currentPage)...")
        guard !isLoading && hasMore else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            let newUsers = try await getUserListUseCase.execute(page: currentPage, perPage: 30)
            let existingIDs = Set(users.map { $0.id })
            let uniqueNewUsers = newUsers.filter { !existingIDs.contains($0.id) }

            users.append(contentsOf: uniqueNewUsers)
            if newUsers.isEmpty || newUsers.count < 30 {
                hasMore = false
            }
            currentPage += 1
        } catch {
            print("❌ Error on loadMoreUsers: \(error)")
            errorMessage = IdentifiableError(message: error.localizedDescription)
        }
    }

    func refreshUsers() async {
        currentPage = 1
        hasMore = true
        users = []
        await loadMoreUsers()
    }

    func searchUsers(query: String) async {
        guard !query.isEmpty else { return }
        isLoading = true
        defer { isLoading = false }

        do {
            users = try await searchUsersUseCase.execute(query: query, page: 1)
        } catch {
            errorMessage = IdentifiableError(message: error.localizedDescription)
        }
    }
}
