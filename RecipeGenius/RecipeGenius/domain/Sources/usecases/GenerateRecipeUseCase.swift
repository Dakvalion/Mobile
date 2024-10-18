//
//  GenerateRecipeUseCase.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

public class GenerateRecipeUseCase {
    private let recipeGeniusRepository: RecipeGeniusRepository
    
    public init(recipeGeniusRepository: RecipeGeniusRepository) {
        self.recipeGeniusRepository = recipeGeniusRepository
    }
    
    public func execute() -> Recipe {
        return recipeGeniusRepository.generateRecipe()
    }
}
