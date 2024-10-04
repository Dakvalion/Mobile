//
//  GetIngredientsByNameUseCase.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

class GetIngredientsByNameUseCase {
    private let ingredientsRepository: IngredientsRepository
    
    init(ingredientsRepository: IngredientsRepository) {
        self.ingredientsRepository = ingredientsRepository
    }
    
    func execute(name: String) -> Ingredient? {
        return ingredientsRepository.getIngredient(by: name)
    }
}
