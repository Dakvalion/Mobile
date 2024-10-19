//
//  FirebaseService.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 11.10.2024.
//

import Foundation

public protocol FirebaseService {
    func signIn(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
    func createAccount(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void)
}
