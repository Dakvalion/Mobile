//
//  ApiService.swift
//  Lesson13
//
//  Created by Daria Nikitina on 03.12.2024.
//

import Foundation

public protocol ApiService {
    func getTodos(completion: @escaping ([Todo]?) -> Void)
    func updateTodo(_ todo: Todo, completion: @escaping (Bool) -> Void)
}

public class ApiServiceImpl : ApiService {
    
    public let BASE_URL = "https://jsonplaceholder.typicode.com/"
    
    public func getTodos(completion: @escaping ([Todo]?) -> Void) {
        let url = URL(string: "\(BASE_URL)todos")!
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5)
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            guard let serverResponse = try? JSONDecoder().decode([Todo].self, from: data) else {
                completion(nil)
                return
            }
            completion(serverResponse)
        }
        dataTask.resume()
    }
    
    public func updateTodo(_ todo: Todo, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "\(BASE_URL)\(todo.id)")!
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 5)
        urlRequest.httpMethod = "PUT"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(todo)
            let dataTask = URLSession.shared.uploadTask(with: urlRequest, from: jsonData) { data, response, error in
                if let error = error {
                    print(error)
                    completion(false)
                    return
                }
                guard let data = data else {
                    completion(false)
                    return
                }
                completion(true)
            }
            dataTask.resume()
        } catch {
            completion(false)
        }
    }
}
