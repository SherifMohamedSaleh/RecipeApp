//
//  HealthLevelEnum.swift
//  Recipe
//
//  Created by Sherif Abd El-Moniem on 01/12/2021.
//

enum HealthLevel: String, CaseIterable, Decodable {
  case all = "all"
  case LowSugar = "Low Sugar"
  case Keto = "Keto"
  case Vegan = "Vegan"
}

// MARK: -

extension HealthLevel: CustomStringConvertible {
  var description: String {
    return  rawValue.description
  }
}
