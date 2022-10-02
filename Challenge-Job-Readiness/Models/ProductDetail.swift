//
//  ProductDetail.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 21/09/2022.
//

import Foundation

#warning("ProductDetail, we don't use snake case.")
#warning("we need to define if we are going to allow mutation trough attributes or functions, but both is not a good option")
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
    
    mutating func setIsLiked(_ liked : Bool) {
        self.isLiked = liked
    }
}
