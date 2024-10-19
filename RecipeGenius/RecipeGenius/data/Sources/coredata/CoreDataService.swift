//
//  CoreDataService.swift
//
//
//  Created by Daria Nikitina on 08.10.2024.
//

import Foundation

public protocol CoreDataService {
    func getSaved() -> [Recipe]
    func saveRecipe(uid: String, title: String, text: String)
}
