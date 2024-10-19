//
//  SkipAuthUseCase.swift
//  domain
//
//  Created by Daria Nikitina on 08.10.2024.
//

import Foundation

public class SkipAuthUseCase {
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    public func execute() -> Bool {
        authRepository.setNoAuthorizationState()
        return true
    }
}
