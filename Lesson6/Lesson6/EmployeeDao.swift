//
//  EmployeeDao.swift
//  Lesson6
//
//  Created by Дарья Никитина on 12.05.2024.
//

import CoreData

protocol IEmployeeDao {
    func getAll() -> [Employee]
    func getById(_ id: Int) -> Employee?
    func insert(id: Int, name: String, salary: Int)
    func update(_ employee: Employee)
    func delete(_ employee: Employee)
}

class EmployeeDao: IEmployeeDao {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = persistentContainer.viewContext
    
    func getAll() -> [Employee] {
        let request: NSFetchRequest<Employee> = Employee.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            print("❗️Ошибка получения всех: \(error)")
            return []
        }
    }
    
    func getById(_ id: Int) -> Employee? {
        let request: NSFetchRequest<Employee> = Employee.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", Int64(id))
        
        do {
            let result = try viewContext.fetch(request)
            return result.first
        } catch {
            print("❗️Ошибка получения работника по id \(id): \(error)")
            return nil
        }
    }
    
    func insert(id: Int, name: String, salary: Int) {
        let employee = Employee(context: viewContext)
        employee.id = Int64(id)
        employee.name = name
        employee.salary = Int64(salary)
        saveContext()
    }
    
    func update(_ employee: Employee) {
        saveContext()
    }
    
    func delete(_ employee: Employee) {
        viewContext.delete(employee)
        saveContext()
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print("❗️Ошибка сохранения контекста")
            }
        }
    }
}
