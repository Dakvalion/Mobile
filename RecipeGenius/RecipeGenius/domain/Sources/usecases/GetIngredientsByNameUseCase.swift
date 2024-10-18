//
//  GetIngredientsByNameUseCase.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

public class GetIngredientsByNameUseCase {
    private let ingredientsRepository: IngredientsRepository
    
    public init(ingredientsRepository: IngredientsRepository) {
        self.ingredientsRepository = ingredientsRepository
    }
    
    public func execute(name: String) -> Ingredient? {
        return ingredientsRepository.getIngredient(by: name)
    }
}
