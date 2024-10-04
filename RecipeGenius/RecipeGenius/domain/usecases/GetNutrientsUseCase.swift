//
//  GetNutrientsUseCase.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

class GetNutrientsUseCase {
    private let ingredientsRepository: IngredientsRepository
    
    init(ingredientsRepository: IngredientsRepository) {
        self.ingredientsRepository = ingredientsRepository
    }
    
    func execute(name: String) -> (Double, Double, Double, Double) {
        guard let ingredient = ingredientsRepository.getIngredient(by: name)
        else {
            return (0, 0, 0, 0)
        }
        return (ingredient.calories, ingredient.proteins, ingredient.fats, ingredient.carbohydrates)
    }
}
