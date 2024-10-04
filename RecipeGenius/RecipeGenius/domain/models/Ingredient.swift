//
//  Ingredient.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

class Ingredient {
    let name: String
    let weight: Double
    let calories: Double
    let proteins: Double
    let fats: Double
    let carbohydrates: Double
    
    init(
        name: String,
        weight: Double,
        calories: Double,
        proteins: Double,
        fats: Double,
        carbohydrates: Double
    ) {
        self.name = name
        self.weight = weight
        self.calories = calories
        self.proteins = proteins
        self.fats = fats
        self.carbohydrates = carbohydrates
    }
}
