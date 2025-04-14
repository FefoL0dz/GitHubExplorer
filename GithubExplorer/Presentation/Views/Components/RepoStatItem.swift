//
//  RepoStatItem.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import SwiftUI

struct RepoStatItem: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(label.uppercased())
                .font(.caption)
                .foregroundColor(.secondary)
            Text(value)
                .font(.body.bold())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
