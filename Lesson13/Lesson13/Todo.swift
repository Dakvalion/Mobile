//
//  Todo.swift
//  Lesson13
//
//  Created by Daria Nikitina on 03.12.2024.
//

import Foundation

public class Todo: Codable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}
