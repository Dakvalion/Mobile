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
        ingredients.compactMap { ingredient in
            guard let ingredientName = ingredient.strIngredient,
                  let emoji = getEmoji(by: ingredientName) else { return nil }
            return domain.Ingredient(name: ingredient.strIngredient ?? "",
                              emoji: emoji,
                              strDescription: ingredient.strDescription ?? "",
                              type: ingredient.strType ?? "")
        }
    }
    
    private func getEmoji(by name: String) -> String? {
        return emojiDict[name]
    }
    
    private let emojiDict: [String: String] = [
        "Chicken": "🍗",
        "Salmon": "🐟",
        "Beef": "🥩",
        "Pork": "🍖",
        "Avocado": "🥑",
        "Asparagus": "🥬",
        "Aubergine": "🍆",
        "Bacon": "🥓",
        "Basil": "🌿",
        "Basmati Rice": "🍚",
        "Bay Leaves": "🍃",
        "Beef Brisket": "🥩",
        "Salt": "🧂",
        "Bread": "🍞",
        "Broccoli": "🥦",
        "Butter": "🧈",
        "Carrots": "🥕",
        "Cheese": "🧀",
        "Chilli": "🌶",
        "Cucumber": "🥒",
        "Egg": "🥚",
        "Garlic": "🧄",
        "Honey": "🍯",
        "Lemon": "🍋",
        "Milk": "🥛",
        "Onions": "🧅",
        "Oysters": "🦪",
        "Peanuts": "🥜",
        "Potatoes": "🥔",
        "Rice": "🍚",
        "Sake": "🍶",
        "Strawberries": "🍓",
        "Tomatoes": "🍅",
        "Pretzels": "🥨",
        "Banana": "🍌",
        "Peaches": "🍑",
        "Cherry": "🍒",
        "Apples": "🍎",
        "Pears": "🍐"
    ]
}
