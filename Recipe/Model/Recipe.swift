//
//  Recipe.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 01/12/2021.
//

import Foundation
import ObjectMapper

class Recipe : NSObject, Mappable , Codable{
    
    var calories : Int?
    var cautions : [String]?
    var co2EmissionsClass : String?
    var cuisineType : [String]?
    var dietLabels : [String]?
    var dishType : [String]?
    var glycemicIndex : Int?
    var healthLabels : [String]?
    var image : String?
    var ingredientLines : [String]?
    var label : String?
    var mealType : [String]?
    var shareAs : String?
    var source : String?
    var totalCO2Emissions : Int?
    var totalWeight : Int?
    var uri : String?
    var url : String?
    var yield : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Recipe()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        calories <- map["calories"]
        cautions <- map["cautions"]
        co2EmissionsClass <- map["co2EmissionsClass"]
        cuisineType <- map["cuisineType"]
        dietLabels <- map["dietLabels"]
        dishType <- map["dishType"]
        glycemicIndex <- map["glycemicIndex"]
        healthLabels <- map["healthLabels"]
        image <- map["image"]
        ingredientLines <- map["ingredientLines"]
        label <- map["label"]
        mealType <- map["mealType"]
        shareAs <- map["shareAs"]
        source <- map["source"]
        totalCO2Emissions <- map["totalCO2Emissions"]
        totalWeight <- map["totalWeight"]
        uri <- map["uri"]
        url <- map["url"]
        yield <- map["yield"]
        
    }
}
