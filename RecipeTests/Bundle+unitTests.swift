//
//  Bundle+unitTests.swift
//  RecipeTests
//
//  Created by Sherif Abd El-Moniem on 01/12/2021.
//

import Foundation
import Foundation

extension Bundle {
    public class var unitTest: Bundle {
        return Bundle(for: RecipeTests.self)
    }
}
