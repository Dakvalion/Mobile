//
//  RecipeGeniusRepositoryImpl.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

class RecipeGeniusRepositoryImpl: RecipeGeniusRepository {
    private let sharedPreferences = UserDefaults.standard
    
    func generateRecipe() -> Recipe {
        Recipe(
            title: "Вкусные блины",
            description: "Мои домашние съедают за 3.3 секунды. Всё очень просто: \nЯйца взбейте с сахаром и солью. Муку просеять и добавить к взбитым яйцам. Размещать до консистенции густой однородной массы и на скороводу жарь уже быстрее",
            ingredients: [
                Ingredient(
                    name: "Яйца",
                    weight: 80.0,
                    calories: 33.5,
                    proteins: 20.0,
                    fats: 1.2,
                    carbohydrates: 5.7
                ),
                Ingredient(
                    name: "Молоко",
                    weight: 200.0,
                    calories: 40.0,
                    proteins: 20.0,
                    fats: 3.4,
                    carbohydrates: 6.8
                )
            ]
        )
    }
    
    func saveToStorage(recipe: Recipe) -> Bool {
        return true
    }
}
