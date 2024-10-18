//
//  GetNutrientsUseCase.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

public class GetNutrientsUseCase {
    private let ingredientsRepository: IngredientsRepository
    
    public init(ingredientsRepository: IngredientsRepository) {
        self.ingredientsRepository = ingredientsRepository
    }
    
    public func execute(name: String) -> (Double, Double, Double, Double) {
        guard let ingredient = ingredientsRepository.getIngredient(by: name)
        else {
            return (0, 0, 0, 0)
        }
        return (ingredient.calories, ingredient.proteins, ingredient.fats, ingredient.carbohydrates)
    }
}
