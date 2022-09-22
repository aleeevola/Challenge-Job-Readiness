//
//  LikedViewPresenter.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 22/09/2022.
//

import Foundation

protocol LikedPesenter {
    func searchLikeds() -> Void
    func likedTapped(_ productId : String)
}

class LikedViewPesenter: LikedPesenter {
  
  // MARK: - Attributes
  
  weak var delegate: LikedViewDelegate?
  private let service: ProductService
  
  // MARK: - Init
  
  init(service: ProductService) {
    self.service = service
  }
  
  // MARK: - Internal Functions
  
    func searchLikeds() -> Void {
        self.service.fetchLiked() { result in
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
