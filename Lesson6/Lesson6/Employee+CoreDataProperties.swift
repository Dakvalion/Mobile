//
//  Employee+CoreDataProperties.swift
//  Lesson6
//
//  Created by Дарья Никитина on 12.05.2024.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String
    @NSManaged public var salary: Int64
    @NSManaged public var id: Int64

}

extension Employee : Identifiable {

}
