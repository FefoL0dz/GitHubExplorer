//
//  IdentifiableError.swift
//  GithubExplorer
//
//  Created by Felipe Framework on 13/04/25.
//

import Foundation

struct IdentifiableError: Identifiable, Equatable {
    let id = UUID()
    let message: String
}
