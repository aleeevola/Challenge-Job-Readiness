//
//  ProductDetail.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 21/09/2022.
//

import Foundation

struct Product_detail: Codable {
    let id: String
    let name: String
    let price: Double
    var details: String
    let imageUrl: String
    var isLiked: Bool
    
    mutating func setDescription(_ description : String) {
        self.details = description
    }
}
