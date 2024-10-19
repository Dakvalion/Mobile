//
//  CoreDataServiceImpl.swift
//  
//
//  Created by Daria Nikitina on 08.10.2024.
//

import CoreData

public class CoreDataServiceImpl: CoreDataService {
    private let persistentContainer: NSPersistentContainer
    private let trueValue = NSNumber(value: true)
    
    public init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Опять ошибочка при загрузке хранилища: \(error), \(error.userInfo)")
            }
        }
    }
    
    public func getSaved() -> [Recipe] {
        let fetchRequest = Recipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "saved = %@", trueValue)
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print("Снова ошибочка при fetch: \(error.localizedDescription)")
            return []
        }
    }
    
    public func saveRecipe(uid: String, title: String, text: String) {
        let recipe = Recipe(context: persistentContainer.viewContext)
        recipe.uid = uid
        recipe.title = title
        recipe.text = text
        saveContext()
    }
    
    private func saveContext() {
        guard persistentContainer.viewContext.hasChanges else { return }
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Ошибочка сохранения: \(error.localizedDescription)")
        }
    }
}
