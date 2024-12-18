//
//  NetworkApi.swift
//  data
//
//  Created by Daria Nikitina on 08.10.2024.
//

import Foundation

public class NetworkApi: INetworkApi {
    private let url = "www.themealdb.com/api/json/v1/1/list.php?i=list"
    
    public init() {}
    
    public func getIngredients(completion: @escaping (Result<ServerResponse, NetworkError>) -> Void) {
        downloadData { [weak self] (data, response, error) in
            guard let self = self else {
                completion(.failure(.unknown))
                return
            }
            if let error = error {
                print("ОШИБКА: \(error)")
                completion(.failure(.error(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            guard let serverResponse = try? JSONDecoder().decode(ServerResponse.self, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            completion(.success(serverResponse))
        }
    }
    
    private func downloadData(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var urlRequest = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5)
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: completionHandler)
        dataTask.resume()
    }
}
