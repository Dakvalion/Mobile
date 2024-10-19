//
//  CreateAccountUseCase.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 07.10.2024.
//

import Foundation

public class CreateAccountUseCase {
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    public func execute(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        authRepository.createAccount(email: email, password: password, completion: completion)
    }
}
