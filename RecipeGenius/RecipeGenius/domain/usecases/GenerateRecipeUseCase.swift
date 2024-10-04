//
//  GenerateRecipeUseCase.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

class GenerateRecipeUseCase {
    private let recipeGeniusRepository: RecipeGeniusRepository
    
    init(recipeGeniusRepository: RecipeGeniusRepository) {
        self.recipeGeniusRepository = recipeGeniusRepository
    }
    
    func execute() -> Recipe {
        return recipeGeniusRepository.generateRecipe()
    }
}
