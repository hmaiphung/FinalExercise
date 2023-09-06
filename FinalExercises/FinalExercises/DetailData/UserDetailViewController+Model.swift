//
//  UserDetailViewController+Model.swift
//  FinalExercises
//
//  Created by Phung Huy on 30/08/2023.
//

import Foundation


struct DetailData: Codable {
    let name: String
    let avatar_url: String
    let followers: Int
    let created_at: String
    let email: String
}
