//
//  Product.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 16/09/2022.
//

import Foundation

struct Product: Codable {
    let id: String
    let name: String
    let price: Double
    let extraDetails: String
    let location: String
    let imageUrl: String
    let isLiked: Bool
}
