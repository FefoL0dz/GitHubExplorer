//
//  RepoRow.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import SwiftUI

struct RepoRow: View {
    let repo: Repository

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(repo.name)
                .font(.headline)

            if let desc = repo.description {
                Text(desc)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            HStack {
                if let language = repo.primaryLanguage {
                    Text(language)
                        .font(.caption)
                }
                Text("⭐ \(repo.stars)")
                    .font(.caption)
            }
        }
        .padding(.vertical, 4)
    }
}

