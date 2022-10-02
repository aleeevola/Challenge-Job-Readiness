//
//  SearchService.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 12/09/2022.
//

import Foundation
import Alamofire

#warning("We should apply solid here, maybe this interface is doing a lot")
#warning("1. Fetching by differents options, liking a product")
protocol ProductService{
  func fetchProducts(search: String, callback: @escaping (Multiget) -> Void) -> Void
  func fetchProduct(productId: String, callback: @escaping (Multiget) -> Void) -> Void
  func fetchDescription(productId: String, callback: @escaping (String) -> Void) -> Void
  func fetchLiked(callback: @escaping (Multiget) -> Void) -> Void
  func likeProduct(_ productId: String)
}

#warning("CodeStyling, should be consistent trough the whole app")
#warning("We need to handle errors. ")
#warning("Suggestion: Use more guards for a better and more simple way of handling some cases")
#warning("Use guards when you try to discard situation that they aren't the happy path")
final class SearchService: ProductService {
  static let shared = SearchService()
  
  private init() {}
  
  private let defaults = UserDefaults.standard
  private let restClient = RestClient.shared
  
  private var likedProducts: [String]? { self.defaults.stringArray(forKey: "LikedProducts") }
  
  func fetchProduct(productId: String, callback: @escaping (Multiget) -> Void) {
    self.fetchProductsDetail(search: [productId], callback: callback)
  }
  
#warning("Starting to feel like a piramyd of doom which meens too much logic and hard to reed or follow")
  func fetchProducts(search: String, callback: @escaping (Multiget) -> Void) -> Void {
    self.fetchCategory(search: search) { categoryCode in
      guard !categoryCode.isEmpty else { return callback([]) }
      
      self.fetchTopProduct(search: categoryCode) { productsIds in
        guard !productsIds.isEmpty else { return callback([]) }
        
        debugPrint(productsIds)
        self.fetchProductsDetail(search: productsIds, callback: callback)
      }
    }
  }
  
  func fetchDescription(productId: String, callback: @escaping (String) -> Void) -> Void {
    self.restClient.call(.get, "items/\(productId)/description") { ( result : Result<DescriptionDto, Error> ) in
      switch result {
      case .success(let description) :
        callback(description.plainText)
      case .failure(let error) :
        debugPrint("fetchDescription",error.localizedDescription)
      }
    }
  }
  
  #warning("I was hard for me to know that Multiget is an array.")
  func fetchLiked(callback : @escaping (Multiget) -> Void) -> Void {
    guard let likes = likedProducts else { return callback([]) }
    
    self.fetchProductsDetail(search: likes, callback: callback)
  }
  
  func likeProduct(_ productId: String) {
    guard var likes = likedProducts else { return saveProducts([productId]) }
    
    if let index = likes.firstIndex(of: productId) {
      likes.remove(at: index)
    } else {
      likes.append(productId)
    }
    saveProducts(likes)
  }
  
  #warning("We use debug print because maybe we have many of them and using print means we are going to print it on Debug or Release Mode.")
  private func saveProducts(_ ids: [String]) {
    debugPrint("Saving Products Likes: ", ids)
    defaults.set(ids, forKey: "LikedProducts")
  }
  
  // MARK: - Private Methods
  private func fetchCategory(search: String, callback : @escaping (String) -> Void) -> Void{
    let parameters: [String: Any] = ["limit": 1, "q": search]
    
    self.restClient.call(.get, "sites/MLA/domain_discovery/search", parameters) { (result: Result<DomainDiscovery, Error>) in
      switch result {
      case .success(let activity) :
        callback(activity.first?.categoryID ?? "")
      case .failure(let error) :
        debugPrint("fetchCategory", error.localizedDescription)
      }
    }
  }
  
  private func fetchTopProduct(search: String, callback : @escaping ([String]) -> Void) -> Void{
    self.restClient.call(.get, "highlights/MLA/category/\(search)") { ( result : Result<Category, Error> ) in
      switch result {
      case .success(let productsIds) :
        callback(productsIds.content.filter{ $0.type == .item }.map{$0.id})
      case .failure(let error) :
        debugPrint("fetchTopProduct", error.localizedDescription)
      }
    }
  }
  
  private func fetchProductsDetail(search: [String], callback: @escaping (Multiget) -> Void) -> Void {
    let parameters: [String:Any] = ["ids": search.joined(separator: ",")]
    
    self.restClient.call(.get, "items", parameters) { (result: Result<Multiget, Error>) in
      switch result {
      case .success(let productsDetails) :
        callback(productsDetails)
      case .failure(let error) :
        debugPrint("fetchProductsDetail",error.localizedDescription)
      }
    }
  }
}
