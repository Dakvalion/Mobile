//
//  Ingredient.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

public class Ingredient {
    public let name: String
    public let weight: Double
    public let calories: Double
    public let proteins: Double
    public let fats: Double
    public let carbohydrates: Double
    
    public init(
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
