//
//  IngredientsRepositoryImpl.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import domain

public class IngredientsRepositoryImpl: IngredientsRepository {
    
    public func getIngredientsList() -> [Ingredient] {
        return [
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
    }
    
    public func getIngredient(by name: String) -> Ingredient? {
        return Ingredient(
            name: "Молоко",
            weight: 200.0,
            calories: 40.0,
            proteins: 20.0,
            fats: 3.4,
            carbohydrates: 6.8
        )
    }
}
