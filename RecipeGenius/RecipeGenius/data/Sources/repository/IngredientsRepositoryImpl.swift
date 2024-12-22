//
//  IngredientsRepositoryImpl.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import domain

public class IngredientsRepositoryImpl: IngredientsRepository {
    private let networkApi: INetworkApi
    private let sharedPreferences: SharedPreferencesService
    
    public init(networkApi: INetworkApi, sharedPreferences: SharedPreferencesService) {
        self.networkApi = networkApi
        self.sharedPreferences = sharedPreferences
    }
    
    public var isLogin: Bool {
        sharedPreferences.isLogin
    }
    
    public func getIngredientsList(completion: @escaping (Result<[domain.Ingredient], Error>) -> Void) {
        networkApi.getIngredients { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let serverResponse):
                completion(.success(mapToDomain(ingredients: serverResponse.meals ?? [])))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    public func getIngredient(by name: String) -> domain.Ingredient? {
        return domain.Ingredient(name: "Молоко",
                                 emoji: "🥛",
                                 strDescription: "Молоко дают коровы",
                                 type: "Молочное")
    }
    
    private func mapToDomain(ingredients: [Ingredient]) -> [domain.Ingredient] {
        ingredients.map { ingredient in
            domain.Ingredient(name: ingredient.strIngredient ?? "",
                              emoji: getEmoji(by: ingredient.idIngredient),
                              strDescription: ingredient.strDescription ?? "",
                              type: ingredient.strType ?? "")
        }
    }
    
    private func getEmoji(by id: String?) -> String {
        return "🍗"
    }
}
