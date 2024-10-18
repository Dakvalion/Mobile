//
//  SignInUseCase.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 07.10.2024.
//

import Foundation

public class SignInUseCase {
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    public func execute(email: String, password: String) -> User? {
        authRepository.signIn(email: login, password: password) { result in
            switch result {
            case .success(let success):
                return success
            case .failure(let failure):
                return nil
            }
        }
    }
}
