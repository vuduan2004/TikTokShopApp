//
//  APIHandler.swift
//  TikTokShop
//
//  Created by Khắc Hùng on 03/07/2023.
//

import Foundation
import Alamofire

class APIHandler {
    let BASE_SPHOTAPI_URL = "https://64a25256b45881cc0ae4fc33.mockapi.io/dsSPHot"
    let BASE_SHIRTSAPI_URL = "https://64a25256b45881cc0ae4fc33.mockapi.io/shirts"
    
    func getSPHots (completion: @escaping (Products) -> ()) {
        AF.request("\(BASE_SPHOTAPI_URL)", method: .get).responseDecodable(of: Products.self){
            (respone) in
            if let productResponse = respone.value {
                completion(productResponse)
            }
        }
    }
    
    func getShirts (completion: @escaping (Products) -> ()) {
        AF.request("\(BASE_SHIRTSAPI_URL)", method: .get).responseDecodable(of: Products.self){
            (respone) in
            if let productResponse = respone.value {
                completion(productResponse)
            }
        }
    }
    
    
    
}
