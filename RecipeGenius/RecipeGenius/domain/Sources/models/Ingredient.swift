//
//  Ingredient.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 28.09.2024.
//

import Foundation

public class Ingredient {
    public let name: String
    public let emoji: String
    public let strDescription: String
    public let type: String
    
    public init(name: String, emoji: String, strDescription: String, type: String) {
        self.name = name
        self.emoji = emoji
        self.strDescription = strDescription
        self.type = type
    }
}
