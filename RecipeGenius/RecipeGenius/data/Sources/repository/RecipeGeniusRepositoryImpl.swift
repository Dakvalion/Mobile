//
//  RecipeGeniusRepositoryImpl.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation
import domain

public class RecipeGeniusRepositoryImpl: RecipeGeniusRepository {
    private let sharedPreferences: SharedPreferencesService
    private let coreDataService: CoreDataService
    
    public init(sharedPreferences: SharedPreferencesService, coreDataService: CoreDataService) {
        self.sharedPreferences = sharedPreferences
        self.coreDataService = coreDataService
    }
    
    public func generateRecipe() -> domain.Recipe {
        return domain.Recipe(
            title: "Вкусные блины",
            description: "Мои домашние съедают за 3.3 секунды. Всё очень просто: \nЯйца взбейте с сахаром и солью. Муку просеять и добавить к взбитым яйцам. Размещать до консистенции густой однородной массы и на скороводу жарь уже быстрее",
            ingredients: []
        )
    }
    
    public func saveToStorage(recipe: domain.Recipe) -> Bool {
        if sharedPreferences.isLogin {
            let uid = sharedPreferences.getUser().uid
            coreDataService.saveRecipe(uid: uid, title: recipe.title, text: recipe.description)
            return true
        } else {
            return false
        }
    }
}
