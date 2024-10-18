//
//  Recipe.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

public class Recipe {
    public let title: String
    public let description: String
    public let ingredients: [Ingredient]
    
    public init(title: String, description: String, ingredients: [Ingredient]) {
        self.title = title
        self.description = description
        self.ingredients = ingredients
    }
}
