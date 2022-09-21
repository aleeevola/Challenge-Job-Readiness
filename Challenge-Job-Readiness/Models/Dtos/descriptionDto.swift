// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let descriptionDto = try? newJSONDecoder().decode(DescriptionDto.self, from: jsonData)

import Foundation

// MARK: - DescriptionDto
struct DescriptionDto: Codable {
    let text, plainText, lastUpdated, dateCreated: String
    let snapshot: Snapshot

    enum CodingKeys: String, CodingKey {
        case text
        case plainText = "plain_text"
        case lastUpdated = "last_updated"
        case dateCreated = "date_created"
        case snapshot
    }
}

// MARK: - Snapshot
struct Snapshot: Codable {
    let url: String
    let width, height: Int
    let status: String
}
