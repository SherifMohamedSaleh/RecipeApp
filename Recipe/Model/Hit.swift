//
//  Hit.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 01/12/2021.
//

import Foundation
import ObjectMapper

class Hit : NSObject, Mappable , Codable{
    
    var recipe : Recipe?
    
    class func newInstance(map: Map) -> Mappable?{
        return Hit()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        recipe <- map["recipe"]
    }
}
