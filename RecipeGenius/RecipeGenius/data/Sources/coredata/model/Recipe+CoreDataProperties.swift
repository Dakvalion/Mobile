//
//  Recipe+CoreDataProperties.swift
//  data
//
//  Created by Daria Nikitina on 08.10.2024.
//
//

import Foundation
import CoreData


extension Recipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipe> {
        return NSFetchRequest<Recipe>(entityName: "Recipe")
    }

    @NSManaged public var title: String?
    @NSManaged public var uid: String?
    @NSManaged public var text: String?
    @NSManaged public var saved: NSNumber?

}

extension Recipe : Identifiable {

}

extension Recipe {
    public var isSaved: Bool {
        get { return saved?.boolValue ?? false }
        set { saved = newValue as NSNumber? }
    }
}
