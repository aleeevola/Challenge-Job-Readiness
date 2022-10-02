//
//  oauthToken.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 13/09/2022.
//

import Foundation

#warning("Class should start with upper letter, AuthToken")
#warning("Also, we are not using this class")
struct oauthToken: Codable {
    let accessToken, tokenType: String
    let expiresIn: Int
    let scope: String
    let userID: Int
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
        case userID = "user_id"
        case refreshToken = "refresh_token"
    }
}
