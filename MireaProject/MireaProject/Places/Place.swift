//
//  Place.swift
//  MireaProject
//
//  Created by Дарья Никитина on 11.06.2024.
//

import YandexMapsMobile

class Place {
    let name: String
    let description: String
    let imagePath: String
    let point: YMKPoint
    
    init(name: String, description: String, imagePath: String, point: YMKPoint) {
        self.name = name
        self.description = description
        self.imagePath = imagePath
        self.point = point
    }
}
