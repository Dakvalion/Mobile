//
//  INetworkApi.swift
//  data
//
//  Created by Daria Nikitina on 08.10.2024.
//

import Foundation

public protocol INetworkApi {
    func getIngredients(completion: @escaping (Result<ServerResponse, NetworkError>) -> Void)
}
