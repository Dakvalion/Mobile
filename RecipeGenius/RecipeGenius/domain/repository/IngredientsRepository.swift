//
//  IngredientsRepository.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

protocol IngredientsRepository {
    func getIngredientsList() -> [Ingredient]
    func getIngredient(by name: String) -> Ingredient?
}
