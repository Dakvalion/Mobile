//
//  Ingredient.swift
//  data
//
//  Created by Daria Nikitina on 08.10.2024.
//

import Foundation

public class Ingredient: Decodable {
    public let idIngredient: String?
    public let strIngredient: String?
    public let strDescription: String?
    public let strType: String?
    
    public init(idIngredient: String?, strIngredient: String?, strDescription: String?, strType: String?) {
        self.idIngredient = idIngredient
        self.strIngredient = strIngredient
        self.strDescription = strDescription
        self.strType = strType
    }
}
