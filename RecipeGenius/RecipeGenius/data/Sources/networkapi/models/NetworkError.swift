//
//  NetworkError.swift
//
//
//  Created by Daria Nikitina on 08.10.2024.
//

import Foundation

public enum NetworkError: Error {
    case unknown
    case error(Error)
    case noData
    case decodingError
}
