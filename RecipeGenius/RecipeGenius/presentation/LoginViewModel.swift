//
//  LoginViewModel.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 01.11.2024.
//

import Foundation
import domain

class LoginViewModel: ViewModel {
    private let authRepository: AuthRepository
    
    var user: User?
    var error: Error?
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func signIn(loginInput: String?, passwordInput: String?) {
        guard let email = loginInput, !email.isEmpty,
              let password = passwordInput, !password.isEmpty else {
            return
        }
        SignInUseCase(authRepository: authRepository).execute(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            var success = false
            switch result {
            case .success(let user):
                self.user = user
                success = true
            case .failure(let error):
                self.error = error
            }
            NotificationCenter.default.post(name: Notification.Name("AuthStateChanged"), object: success)
        }
    }
    
    func createAccount(loginInput: String?, passwordInput: String?) {
        guard let email = loginInput, !email.isEmpty,
              let password = passwordInput, !password.isEmpty else {
            return
        }
        CreateAccountUseCase(authRepository: authRepository).execute(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            var success = false
            switch result {
            case .success(let user):
                self.user = user
                success = true
            case .failure(let error):
                self.error = error
            }
            NotificationCenter.default.post(name: Notification.Name("AuthStateChanged"), object: success)
        }
    }
    
    func skipAuth() -> Bool {
        let result = SkipAuthUseCase(authRepository: authRepository).execute()
        return result
    }
}
