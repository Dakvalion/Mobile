//
//  IngredientViewModel.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 17.11.2024.
//

import Foundation
import Combine
import data

class IngredientViewModel: ViewModel {
    @Published private(set) var ingredients: [Ingredient] = []
    @Published private(set) var error: NetworkError?
    
    private var cancellables = Set<AnyCancellable>()
    private let networkApi = NetworkApi()
    
    override init() {
        super.init()
        fetchIngredients()
    }
    
    func addIngredient(_ ingredient: Ingredient) {
        ingredients.append(ingredient)
    }
    
    func fetchIngredients() {
        networkApi.getIngredients { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.ingredients = success.data ?? []
            case .failure(let failure):
                self.error = failure
            }
        }
    }
}
