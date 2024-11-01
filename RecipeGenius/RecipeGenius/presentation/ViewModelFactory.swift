//
//  ViewModelFactory.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 01.11.2024.
//

import data
import domain

class ViewModelFactory {
    func create<T>(modelClass: T.Type) -> T where T : ViewModel {
        let firebaseService: FirebaseService = FirebaseServiceImpl()
        let sharedPreferencesService: SharedPreferencesService = SharedPreferencesServiceImpl()
        let authRepository: AuthRepository = AuthRepositoryImpl(firebaseService: firebaseService, sharedPreferences: sharedPreferencesService)
        return LoginViewModel(authRepository: authRepository) as! T
    }
}
