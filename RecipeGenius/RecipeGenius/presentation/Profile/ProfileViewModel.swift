//
//  ProfileViewModel.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 18.12.2024.
//

import domain
import Combine

class ProfileViewModel: ViewModel {
    @Published private(set) var user: User?
    
    private let storageRepository: StorageRepository
    private let authRepository: AuthRepository
    
    init(storageRepository: StorageRepository, authRepository: AuthRepository) {
        self.storageRepository = storageRepository
        self.authRepository = authRepository
        super.init()
        fetchUser()
    }
    
    var isLogin: Bool {
        storageRepository.isLogin
    }
    
    func fetchUser() {
        self.user = storageRepository.getUser()
    }
    
    func logout() {
        authRepository.logout()
    }
}
