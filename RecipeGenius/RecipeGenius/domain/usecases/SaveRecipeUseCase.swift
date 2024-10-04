//
//  SaveRecipeUseCase.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

class SaveRecipeUseCase {
    private let recipeGeniusRepository: RecipeGeniusRepository
    
    init(recipeGeniusRepository: RecipeGeniusRepository) {
        self.recipeGeniusRepository = recipeGeniusRepository
    }
    
    func execute(recipe: Recipe) -> Bool {
        recipeGeniusRepository.saveToStorage(recipe: recipe)
    }
}
