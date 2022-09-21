// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let multiget = try? newJSONDecoder().decode(Multiget.self, from: jsonData)

import Foundation

// MARK: - MultigetElement
struct MultigetElement: Codable {
    let code: Int
    let body: Body
}

// MARK: - Body
struct Body: Codable {
    
    let id, title : String
    let price: Int
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case thumbnail
    }
}

typealias Multiget = [MultigetElement]
