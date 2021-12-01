//
//  RecipeModel.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 30/11/2021.
//

import Foundation
import ObjectMapper


class RecipeModel : NSObject, Mappable , Codable{
    
    var count : Int?
    var from : Int = 0
    var hits : [Hit]?
    var to : Int = 10
    
    class func newInstance(map: Map) -> Mappable?{
        return RecipeModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        count <- map["count"]
        from <- map["from"]
        hits <- map["hits"]
        to <- map["to"]
    }
}


