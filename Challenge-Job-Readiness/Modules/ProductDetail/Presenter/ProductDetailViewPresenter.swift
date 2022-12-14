//
//  ProductDetailViewModel.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 21/09/2022.
//

import Foundation

protocol ProductDetailPresenter {
    func searchProduct(productId: String) -> Void
    func likedTapped(_ productId : String)
}

class ProductDetailViewPresenter : ProductDetailPresenter{
    // MARK: - Attributes
    private let service: ProductService
    weak var delegate: ProductDetailViewDelegate?
    
    // MARK: - Init
    init(service: ProductService) {
        self.service = service
    }
    
    // MARK: - Methods
    func searchProduct(productId: String) -> Void {
        self.service.fetchProduct(productId: productId) { result in
            if result.isEmpty {
                //self.delegate?.showError("No se encontraro productos")
            }
            else{
                self.service.fetchDescription(productId: productId) { description in
                    var model = result.map{$0.productDetailModel}.first!
                    model.setDescription(description)
                    
                    self.delegate?.setProduct(model)
                }
                
            }
        }
    }
    
    func likedTapped(_ productId : String){
        self.service.likeProduct(productId)
    }
}

extension MultigetElement {
    var productDetailModel : Product_detail { Product_detail(
        id: body.id,
        name: body.title,
        price: Double(body.price),
        details: "Prueba",
        imageUrl: body.pictures.first?.secureURL ?? "",
        isLiked: false)
    }
}
