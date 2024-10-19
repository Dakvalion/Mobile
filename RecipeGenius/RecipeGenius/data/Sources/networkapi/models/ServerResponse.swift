//
//  ServerResponse.swift
//  data
//
//  Created by Daria Nikitina on 08.10.2024.
//

import Foundation

public class ServerResponse: Decodable {
    public let status: String?
    public let data: [Ingredient]?
    
    public init(status: String?, data: [Ingredient]?) {
        self.status = status
        self.data = data
    }
}
