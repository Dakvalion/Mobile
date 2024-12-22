//
//  IngredientsRepository.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

public protocol IngredientsRepository {
    var isLogin: Bool { get }
    func getIngredientsList(completion: @escaping (Result<[Ingredient], Error>) -> Void)
    func getIngredient(by name: String) -> Ingredient?
}
