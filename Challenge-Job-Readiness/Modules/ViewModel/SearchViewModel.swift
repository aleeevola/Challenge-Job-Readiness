//
//  SearchViewModel.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 20/09/2022.
//

import Foundation

class SearchViewModel {
    
    private let service: SearchService
    private weak var delegate: SearchViewDelegate?
    
    init(service: SearchService, delegate: SearchViewDelegate?) {
        self.service = service
        self.delegate = delegate
    }
    
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
        extraDetails: "Nuevo",
        location: "CABA",
        imageUrl: body.thumbnail,
        isLiked: false)
    }
}
