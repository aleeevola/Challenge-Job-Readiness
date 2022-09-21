//
//  RestClient.swift
//  Challenge-Job-Readiness
//
//  Created by Alejandro Bruno Vola on 12/09/2022.
//
import Alamofire
import Foundation



final class RestClient{
    static let shared = RestClient()
    
    private init(){}
    
    let BASE_URL = "https://api.mercadolibre.com/"
    private let CODE = "TG-631f43e26230f700017c8299-204640350"
    private let CLIENT_ID = "2823795960356823"
    private let CLIENT_SECRET = "2823795960356823"
    private let REDIRECT_URI = "https://www.alkemy.org/"
    private let ACCESS_TOKEN = "APP_USR-2823795960356823-092022-47aeb032a4b16a3f64f701b21ddb5fc4-204640350"
    
    
    func call<Model: Decodable>(_ method: HTTPMethod, _ request: String,_ parameters: [String:Any]? = nil, callback: @escaping ((Result<Model,Error>) -> Void)){
        
        let url = self.BASE_URL + request
        
        let headers = HTTPHeaders(["Authorization" : "Bearer \(self.ACCESS_TOKEN)"])
        
        let request = AF.request(url, method: method, parameters: parameters, headers: headers).validate(statusCode: 200...300)

        let task = request.response { response in
            switch response.result {
            case .success(let data):
                do {
                    if let data = data {
                        //print(data.toJSON)
                        let result = try JSONDecoder().decode(Model.self, from: data)
                        
                        callback(.success(result))
                    }
                } catch {
                    callback(.failure(error))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
        task.resume()
    }
    

}
extension Data {
 var toJSON: String { String(data: self, encoding: String.Encoding.utf8) ?? "" }
}
