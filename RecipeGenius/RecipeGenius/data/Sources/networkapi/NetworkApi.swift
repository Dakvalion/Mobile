//
//  NetworkApi.swift
//  data
//
//  Created by Daria Nikitina on 08.10.2024.
//

import Foundation

public class NetworkApi: INetworkApi {
    private let url = "www.themealdb.com/api/json/v1/1/list.php?i=list"
    
    public func getIngredients(completion: @escaping (Result<ServerResponse, NetworkError>) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            completion(.success(ServerResponse(
                status: "success",
                data: [Ingredient(id: "1", name: "Мука", weight: 250.0, calories: 10.0, proteins: 0.1, fats: 0.0, carbohydrates: 20.0),
                       Ingredient(id: "2", name: "Сахар", weight: 50.0, calories: 50.0, proteins: 0.0, fats: 4.0, carbohydrates: 15.0)
                      ]
            )))
        }
//        downloadData { [weak self] (data, response, error) in
//            guard let self = self else {
//                completion(.failure(.unknown))
//                return
//            }
//            if let error = error {
//                print("ОШИБКА: \(error)")
//                completion(.failure(.error(error)))
//                return
//            }
//            guard let data = data else {
//                completion(.failure(.noData))
//                return
//            }
//            guard let serverResponse = try? JSONDecoder().decode(ServerResponse.self, from: data) else {
//                completion(.failure(.decodingError))
//                return
//            }
//            completion(.success(serverResponse))
//        }
    }
    
    private func downloadData(completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var urlRequest = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5)
        let dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: completionHandler)
        dataTask.resume()
    }
}
