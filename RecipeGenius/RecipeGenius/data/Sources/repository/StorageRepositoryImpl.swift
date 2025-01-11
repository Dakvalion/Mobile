//
//  StorageRepositoryImpl.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 07.10.2024.
//

import domain

public class StorageRepositoryImpl: StorageRepository {
    public var isLogin: Bool {
        return sharedPreferences.isLogin
    }
    
    private let sharedPreferences: SharedPreferencesService
    
    public init(sharedPreferences: SharedPreferencesService) {
        self.sharedPreferences = sharedPreferences
    }
    
    public func saveUser(_ user: domain.User) -> Bool {
        sharedPreferences.saveUser(mapToData(user: user))
    }
    
    public func getUser() -> domain.User {
        return mapToDomain(user: sharedPreferences.getUser())
    }
    
    public func deleteUser() {
        sharedPreferences.deleteUser()
    }
    
    public func setIsLogin(flag: Bool) {
        sharedPreferences.isLogin = flag
    }
    
    private func mapToDomain(user: User) -> domain.User {
        return domain.User(uid: user.uid, email: user.email)
    }
    
    private func mapToData(user: domain.User) -> User {
        return User(uid: user.uid, email: user.email)
    }
}
