//
//  UserListView.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//
import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel(
        getUserListUseCase: GetUserListUseCase(repository: UserRepositoryImpl()),
        searchUsersUseCase: SearchUsersUseCase(repository: UserRepositoryImpl())
    )

    @State private var searchText = ""

    var body: some View {
        List {
            ForEach(viewModel.users) { user in
                NavigationLink(destination: UserDetailView(username: user.username)) {
                    UserRow(user: user)
                        .onAppear {
                            if user == viewModel.users.last {
                                Task { await viewModel.loadMoreUsers() }
                            }
                        }
                }
            }

            if viewModel.isLoading {
                ProgressView("Loading…")
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            viewModel.searchQuery = newValue
        }
        .navigationTitle("GitHub Users")
        .task {
            if viewModel.users.isEmpty {
                await viewModel.loadMoreUsers()
            }
        }
        .refreshable {
            await viewModel.refreshUsers()
        }
        .alert(item: $viewModel.errorMessage) {
            error in
            Alert(title: Text("Error"), message: Text(error.message), dismissButton: .default(Text("OK")))
        }
    }
}
