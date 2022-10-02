//
//  category.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 13/09/2022.
//

import Foundation

#warning("File should be Category")
// MARK: - Welcome
struct Category: Codable {
    let queryData: QueryData
    let content: [Content]

    enum CodingKeys: String, CodingKey {
        case queryData = "query_data"
        case content
    }
}

// MARK: - Content
struct Content: Codable {
    let id: String
    let position: Int
    let type: TypeEnum
}

enum TypeEnum: String, Codable {
    case item = "ITEM"
    case product = "PRODUCT"
}

// MARK: - QueryData
struct QueryData: Codable {
    let highlightType, criteria, id: String

    enum CodingKeys: String, CodingKey {
        case highlightType = "highlight_type"
        case criteria, id
    }
}

