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
    self.service.fetchLiked() { [weak self] result in
      guard let self = self else { return }
      guard !result.isEmpty else { return self.notifyError("No se encontraron productos") }
      
      self.delegate?.setProducts(result.map{$0.productModel})
    }
  }
  
  func likedTapped(_ productId : String){
    self.service.likeProduct(productId)
  }
  
  private func notifyError(_ message: String) {
    self.delegate?.showError(message)
  }
}
