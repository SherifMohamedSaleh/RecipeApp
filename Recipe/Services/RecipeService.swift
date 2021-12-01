//
//  RecipeService.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 30/11/2021.
//

import Foundation
import ObjectMapper

protocol APIServiceProtocol {
    func getRecipeList( searchText : String , from: Int  , to : Int , success: @escaping ((_ response : RecipeModel)-> Void) ,failure: @escaping (()-> Void))
}


class RecipeService : APIServiceProtocol {
    func getRecipeList( searchText : String , from: Int  , to : Int , success: @escaping ((_ response : RecipeModel)-> Void) ,failure: @escaping (()-> Void)){
        NetworkManager.performRequestWithPath( searchText: searchText , from: from  , to : to ,  requestMethod: .get , success: { (response) in
            if let json = response {
                let recipeModelResponse: RecipeModel = Mapper<RecipeModel>().map(JSON: json as! [String:Any] )!
                success(recipeModelResponse)
            }
        }, failure: {error in
            failure()
        })
    }

}
