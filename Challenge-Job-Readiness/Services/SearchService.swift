//
//  SearchService.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 12/09/2022.
//

import Foundation
import Alamofire

protocol ProductService{
    func fetchProducts(search : String, callback: @escaping (Multiget)->Void) -> Void
    func fetchProduct(productId : String, callback: @escaping (Multiget)->Void) -> Void
    func fetchDescription(productId : String, callback: @escaping (String)->Void) -> Void
}

final class SearchService : ProductService{
    static let shared = SearchService()
    
    private init(){}
    
    private let defaults = UserDefaults.standard
    private var _restClient = RestClient.shared
    
    func fetchProduct(productId: String, callback: @escaping (Multiget) -> Void) {
        self.fetchProductsDetail(search: [productId]) { multiget in
            callback(multiget)
        }
    }
    
    func fetchProducts(search : String, callback: @escaping (Multiget)->Void) -> Void{
        
        self.fetchCategory(search: search) { caregoryCode in
            if caregoryCode.isEmpty {
                callback([])
                return
            }
            self.fetchTopProduct(search: caregoryCode) { productsIds in
                print(productsIds)
                if productsIds.isEmpty {
                    callback([])
                }
                else{
                    self.fetchProductsDetail(search: productsIds) { multiget in
                        callback(multiget)
                    }
                }
            }
        }
    }
    
//    func fetchDescription(productId : String, callback: @escaping (String)->Void) -> Void{
//        self.fetchDescription(productId: productId, callback: { description in
//            callback(description)
//        })
//    }
    
    func likeProduct(_ productId:String){
        if var likes = defaults.stringArray(forKey: "LikedProducts"){
//            print(likes)
            if let index = likes.firstIndex(of: productId) {
                likes.remove(at: index)
            }
            else{
                likes.append(productId)
            }
            defaults.set(likes, forKey: "LikedProducts")
        } else {
            defaults.set([productId], forKey: "LikedProducts")
        }
    }
    
    // MARK: - Private Methods
    private func fetchCategory(search : String, callback : @escaping (String) -> Void) -> Void{
        let parameters : [String:Any] = ["limit":1,"q":search]
        
        self._restClient.call(.get, "sites/MLA/domain_discovery/search", parameters) { (result : Result<DomainDiscovery, Error>) in
            switch result {
            case .success(let activity) :
                callback(activity.first?.categoryID ?? "")
                break
            case .failure(let error) :
                print("fetchCategory",error.localizedDescription)
                break
            }
        }
    }
    
    private func fetchTopProduct(search : String, callback : @escaping ([String]) -> Void) -> Void{
        self._restClient.call(.get, "highlights/MLA/category/\(search)") { ( result : Result<Category, Error> ) in
            switch result {
            case .success(let productsIds) :
                callback(productsIds.content.filter{ $0.type == .item }.map{$0.id})
                break
            case .failure(let error) :
                print("fetchTopProduct",error.localizedDescription)
                break
            }
        }
    }
    
    private func fetchProductsDetail(search : [String], callback : @escaping (Multiget) -> Void) -> Void{
        let parameters : [String:Any] = ["ids":search.joined(separator: ",")]
        
        self._restClient.call(.get, "items",parameters) { ( result : Result<Multiget, Error> ) in
            switch result {
            case .success(let productsDetails) :
                callback(productsDetails)
                break
            case .failure(let error) :
                print("fetchProductsDetail",error.localizedDescription)
                break
            }
        }
    }
    
    func fetchDescription(productId : String, callback : @escaping (String) -> Void) -> Void{
        
        self._restClient.call(.get, "items/\(productId)/description") { ( result : Result<DescriptionDto, Error> ) in
            switch result {
            case .success(let description) :
                callback(description.plainText)
                break
            case .failure(let error) :
                print("fetchDescription",error.localizedDescription)
                break
            }
        }
    }
}
