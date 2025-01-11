//
//  StorageRepository.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 07.10.2024.
//

import Foundation

public protocol StorageRepository {
    func saveUser(_ user: User) -> Bool
    func getUser() -> User
    func deleteUser()
    
    var isLogin: Bool { get }
    func setIsLogin(flag: Bool)
}
