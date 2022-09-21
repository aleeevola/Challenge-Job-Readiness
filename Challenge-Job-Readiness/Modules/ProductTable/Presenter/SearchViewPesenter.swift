//
//  SearchViewPesenter.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 21/09/2022.
//

import Foundation

protocol SearchPesenter {
    func searchProducts(_ search: String) -> Void
    func likedTapped(_ productId : String)
}

class SearchViewPesenter: SearchPesenter {
  
  // MARK: - Attributes
  
  weak var delegate: SearchViewDelegate?
  private let service: ProductService
  
  // MARK: - Init
  
  init(service: ProductService) {
    self.service = service
  }
  
  // MARK: - Internal Functions
  
    func searchProducts(_ search: String) -> Void {
        self.service.fetchProducts(search: search) { result in
            if result.isEmpty {
                self.delegate?.showError("No se encontraro productos")
            }
            else{
                self.delegate?.setProducts(result.map{$0.productModel})
            }
        }
    }
    
    func likedTapped(_ productId : String){
        self.service.likeProduct(productId)
    }
}

extension MultigetElement {
    var productModel : Product { Product(
        id: body.id,
        name: body.title,
        price: Double(body.price),
        location: "CABA",
        imageUrl: body.secureThumbnail,
        isLiked: false)
    }
}
