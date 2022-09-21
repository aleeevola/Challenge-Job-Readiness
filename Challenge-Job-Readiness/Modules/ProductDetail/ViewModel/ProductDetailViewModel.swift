//
//  ProductDetailViewModel.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 21/09/2022.
//

import Foundation

class ProductDetailViewModel {
    
    private let service: SearchService
    private weak var delegate: ProductDetailViewDelegate?
    
    init(service: SearchService, delegate: ProductDetailViewDelegate?) {
        self.service = service
        self.delegate = delegate
    }
    
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
