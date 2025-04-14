//
//  UserRow.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import SwiftUI

struct UserRow: View {
    let user: User

    var body: some View {
        HStack {
            AsyncImage(url: user.avatarURL) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())

            Text(user.username)
                .font(.headline)
        }
        .padding(.vertical, 4)
    }
}

