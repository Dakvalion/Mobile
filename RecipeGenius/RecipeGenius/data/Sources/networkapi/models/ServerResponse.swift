//
//  ServerResponse.swift
//  data
//
//  Created by Daria Nikitina on 08.10.2024.
//

import Foundation

public class ServerResponse: Decodable {
    public let meals: [Ingredient]?
    
    public init(meals: [Ingredient]?) {
        self.meals = meals
    }
}
