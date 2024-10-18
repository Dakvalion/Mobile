//
//  RecipeGeniusRepository.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

public protocol RecipeGeniusRepository {
    func generateRecipe() -> Recipe
    func saveToStorage(recipe: Recipe) -> Bool
}
