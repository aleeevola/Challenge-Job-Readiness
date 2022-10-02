#warning("We should remove this commented code.")
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
    let id: String
    let title: String
    let price: Double

    let secureThumbnail: String
    let pictures: [Picture]

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case secureThumbnail = "secure_thumbnail"
        case pictures
    }
}

// MARK: - Picture
struct Picture: Codable {
    let secureURL: String
    
    enum CodingKeys: String, CodingKey {
        case secureURL = "secure_url"
    }
}

typealias Multiget = [MultigetElement]
