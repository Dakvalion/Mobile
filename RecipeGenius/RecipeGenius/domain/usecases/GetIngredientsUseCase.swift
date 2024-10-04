//
//  GetIngredientsUseCase.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

class GetIngredientsUseCase {
    private let ingredientsRepository: IngredientsRepository

    init(ingredientsRepository: IngredientsRepository) {
        self.ingredientsRepository = ingredientsRepository
    }

    func execute() -> [Ingredient] {
        return ingredientsRepository.getIngredientsList()
    }
}
