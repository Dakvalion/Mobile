//
//  Ingredient.swift
//  data
//
//  Created by Daria Nikitina on 08.10.2024.
//

import Foundation

public class Ingredient: Decodable {
    public let id: String?
    public let name: String?
    public let weight: Double?
    public let calories: Double?
    public let proteins: Double?
    public let fats: Double?
    public let carbohydrates: Double?
    
    public init(
        id: String?,
        name: String?,
        weight: Double?,
        calories: Double?,
        proteins: Double?,
        fats: Double?,
        carbohydrates: Double?
    ) {
        self.id = id
        self.name = name
        self.weight = weight
        self.calories = calories
        self.proteins = proteins
        self.fats = fats
        self.carbohydrates = carbohydrates
    }
}

