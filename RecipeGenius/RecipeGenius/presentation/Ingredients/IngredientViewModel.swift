//
//  IngredientViewModel.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 17.11.2024.
//

import Foundation
import data

class IngredientViewModel: ViewModel {
    @Published private(set) var ingredients: [Ingredient] = []
    
    override init() {
        let mockIngredients = [
            Ingredient(
                id: "1",
                name: "Куриная грудка",
                weight: 100.0,
                calories: 165.0,
                proteins: 31.0,
                fats: 3.6,
                carbohydrates: 0.0
            ),
            Ingredient(
                id: "2",
                name: "Овсяные хлопья",
                weight: 100.0,
                calories: 379.0,
                proteins: 13.1,
                fats: 6.2,
                carbohydrates: 68.9
            ),
            Ingredient(
                id: "3",
                name: "Банан",
                weight: 100.0,
                calories: 89.0,
                proteins: 1.1,
                fats: 0.3,
                carbohydrates: 22.8
            )
        ]
        self.ingredients = mockIngredients
    }
    
    func addIngredient(_ ingredient: Ingredient) {
        ingredients.append(ingredient)
    }
}
