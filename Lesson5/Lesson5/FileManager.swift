//
//  FileManager.swift
//  Lesson5
//
//  Created by Дарья Никитина on 22.04.2024.
//

import Foundation

extension FileManager {
    
    static var documentsDirectory: URL {
        Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
