//
//  ProfileViewModel.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 18.12.2024.
//

import data
import Combine

class ProfileViewModel: ViewModel {
    @Published private(set) var user: User?
    
    private let sharedPreferences: SharedPreferencesService
    
    init(sharedPreferences: SharedPreferencesService) {
        self.sharedPreferences = sharedPreferences
        super.init()
        fetchUser()
    }
    
    func fetchUser() {
        self.user = sharedPreferences.getUser()
    }
}
