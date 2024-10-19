//
//  IngredientsRepositoryImpl.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import domain

public class IngredientsRepositoryImpl: IngredientsRepository {
    private let networkApi: INetworkApi
    
    public init(networkApi: INetworkApi) {
        self.networkApi = networkApi
    }
    
    public func getIngredientsList(completion: @escaping (Result<[domain.Ingredient], Error>) -> Void) {
        networkApi.getIngredients { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let serverResponse):
                completion(.success(mapToDomain(ingredients: serverResponse.data ?? [])))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
//        return [
//            domain.Ingredient(
//                name: "Яйца",
//                weight: 80.0,
//                calories: 33.5,
//                proteins: 20.0,
//                fats: 1.2,
//                carbohydrates: 5.7
//            ),
//            domain.Ingredient(
//                name: "Молоко",
//                weight: 200.0,
//                calories: 40.0,
//                proteins: 20.0,
//                fats: 3.4,
//                carbohydrates: 6.8
//            )
//        ]
    }
    
    public func getIngredient(by name: String) -> domain.Ingredient? {
        return domain.Ingredient(
            name: "Молоко",
            weight: 200.0,
            calories: 40.0,
            proteins: 20.0,
            fats: 3.4,
            carbohydrates: 6.8
        )
    }
    
    private func mapToDomain(ingredients: [Ingredient]) -> [domain.Ingredient] {
        ingredients.map { ingredient in
            domain.Ingredient(name: ingredient.name ?? "", weight: ingredient.weight ?? 0.0, calories: ingredient.calories ?? 0.0, proteins: ingredient.proteins ?? 0.0, fats: ingredient.fats ?? 0.0, carbohydrates: ingredient.carbohydrates ?? 0.0)
        }
    }
}
