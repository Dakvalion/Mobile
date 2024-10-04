//
//  Recipe.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

class Recipe {
    let title: String
    let description: String
    let ingredients: [Ingredient]
    
    init(title: String, description: String, ingredients: [Ingredient]) {
        self.title = title
        self.description = description
        self.ingredients = ingredients
    }
}
