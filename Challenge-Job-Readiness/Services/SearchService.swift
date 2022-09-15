//
//  SearchService.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 12/09/2022.
//

import Foundation
import Alamofire

final class SearchService {

    static let shared = SearchService()
    
    private init(){}
    
    private var _restClient = RestClient.shared
    
    func fetchProducts(search : String){
        self.fetchCategory(search: search) { result in
            switch result {
            case .success(let activity):
                let category = activity.first?.categoryID
                guard !category!.isEmpty else {
                    return
                }
                self.fetchTopProduct(search: category!) { result2 in
                    switch result2 {
                    case.success(let categorys) :
                        print(categorys.content.first)
                    case .failure(let error2) :
                        print(error2)
                    }
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchCategory(search : String, callback : @escaping (Result<DomainDiscovery, Error>) -> Void) -> Void{
        let parameters : [String:Any] = ["limit":1,"q":search]
        
        self._restClient.call(.get, "sites/MLA/domain_discovery/search", parameters, callback: callback)
    }
    
    private func fetchTopProduct(search : String, callback : @escaping (Result<Category, Error>) -> Void) -> Void{
        self._restClient.call(.get, "highlights/MLA/category/\(search)", callback: callback)
    }
}
