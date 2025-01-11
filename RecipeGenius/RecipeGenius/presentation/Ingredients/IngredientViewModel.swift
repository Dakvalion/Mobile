//
//  IngredientViewModel.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 17.11.2024.
//

import Foundation
import Combine
import domain
import data

class IngredientViewModel: ViewModel {
    @Published private(set) var ingredients: [domain.Ingredient] = []
    @Published private(set) var error: Error?
    var isLogin: Bool {
        repository.isLogin
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let repository: IngredientsRepository
    
    init(repository: IngredientsRepository) {
        self.repository = repository
        super.init()
        fetchIngredients()
    }
    
    func fetchIngredients() {
        GetIngredientsUseCase(ingredientsRepository: repository).execute { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let ingredients):
                self.ingredients = ingredients
            case .failure(let error):
                self.error = error
            }
        }
    }
}
