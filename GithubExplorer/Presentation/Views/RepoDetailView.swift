//
//  RepoDetailView.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//
//

import SwiftUI

struct RepoDetailView: View {
    let owner: String
    let repoName: String

    @StateObject private var viewModel = RepoDetailViewModel(
        getRepoDetailUseCase: GetRepoDetailUseCase(repository: RepoRepositoryImpl())
    )

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView("Loading repository...")
                    .padding()
            } else if let repo = viewModel.repository {
                VStack(alignment: .leading, spacing: 24) {

                    VStack(alignment: .leading, spacing: 4) {
                        Text(repo.name)
                            .font(.largeTitle.bold())
                        if let description = repo.description {
                            Text(description)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                    }

                    Divider()

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                        RepoStatItem(label: "Language", value: repo.primaryLanguage ?? "N/A")
                        RepoStatItem(label: "Stars", value: "\(repo.stars)")
                        RepoStatItem(label: "Forks", value: "\(repo.forks)")
                        RepoStatItem(label: "Open Issues", value: "\(repo.openIssues)")
                        RepoStatItem(label: "Private", value: repo.isPrivate ? "Yes" : "No")
                        RepoStatItem(label: "Archived", value: repo.isArchived ? "Yes" : "No")
                        RepoStatItem(label: "Updated", value: repo.lastUpdated.formatted(date: .abbreviated, time: .omitted))
                    }

                    Divider()

                    Link(destination: repo.htmlURL) {
                        Label("View on GitHub", systemImage: "arrow.up.right.square")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                }
                .padding()
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text("No repository data available.")
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
        .navigationTitle(repoName)
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.loadRepository(owner: owner, repoName: repoName)
        }
    }
}
