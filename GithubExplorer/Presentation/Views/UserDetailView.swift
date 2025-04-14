//
//  UserDetailView.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import SwiftUI

struct UserDetailView: View {
    let username: String

    @StateObject private var viewModel = UserDetailViewModel(
        getUserProfileUseCase: GetUserProfileUseCase(repository: UserRepositoryImpl()),
        getUserReposUseCase: GetUserReposUseCase(repository: RepoRepositoryImpl())
    )

    var body: some View {
        ScrollView {
            if let profile = viewModel.profile {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16) {
                        AsyncImage(url: profile.user.avatarURL) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())

                        VStack(alignment: .leading) {
                            Text(profile.fullName ?? "")
                                .font(.headline)
                            Text("@\(profile.user.username)")
                                .foregroundColor(.secondary)
                            if let bio = profile.bio {
                                Text(bio).font(.body)
                            }
                        }
                    }

                    Text("Followers: \(profile.followers) · Following: \(profile.following)")
                        .font(.subheadline)

                    Divider()

                    Text("Repositories")
                        .font(.title2)
                        .bold()

                    ForEach(viewModel.repositories) { repo in
                        NavigationLink(destination: RepoDetailView(owner: username, repoName: repo.name)) {
                            RepoRow(repo: repo)
                        }
                    }
                }
                .padding()
            } else if viewModel.isLoading {
                ProgressView("Loading...")
                    .padding()
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .navigationTitle(username)
        .task {
            await viewModel.fetchDetails(username: username)
        }
    }
}

