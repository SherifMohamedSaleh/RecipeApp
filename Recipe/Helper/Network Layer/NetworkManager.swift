//
//  NetworkManager.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 29/11/2021.
//
//
 
// MARK: - try to add from , to , searchText in parameters

import Foundation
import Alamofire

typealias SuccessNetworkClousre = (Any?)  -> Void
typealias FailureNetworkClousre = (_ error: NSError) -> Void

public class NetworkManager {
    static let app_id = "c67a422e"
    static let app_key = "7180f94ff3749bf62d0848b748fd3f4c"
    
    static let contentTypeKey = "Accept"
    static let contentTypeValue = "application/json"
    
    class func performRequestWithPath (searchText       :String?,
                                       from             :Int ,
                                       to               :Int ,
                                       requestMethod    :Alamofire.HTTPMethod,
                                       success          :@escaping SuccessNetworkClousre,
                                       failure          :@escaping FailureNetworkClousre){
        
        guard let serch = searchText else {
            return
        }
        
        let url = "https://api.edamam.com/api/recipes/v2?type=public&q=\(serch)&app_id=\(app_id)&app_key=\(app_key)&from=\(from)&to=\(to)"
        let headers: HTTPHeaders = [contentTypeKey : contentTypeValue ]
        
        AF.request(url, method: requestMethod, parameters: nil, encoding: JSONEncoding.default , headers: headers)
            .responseJSON { (response) in
                switch response.result {
                case  .success( let succes):
                    success(succes)
                    
                case .failure(let error):
                    failure(error as NSError)
                    break
                }
            }
    }
}

