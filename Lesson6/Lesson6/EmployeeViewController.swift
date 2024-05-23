//
//  EmployeeViewController.swift
//  Lesson6
//
//  Created by Дарья Никитина on 12.05.2024.
//

import UIKit

class EmployeeViewController: UIViewController {
    
    let employeeDao: IEmployeeDao = EmployeeDao()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        employeeDao.insert(id: 1, name: "John Smith", salary: 10000)
        let employees = employeeDao.getAll()
        let employee = employeeDao.getById(1)
        employee?.salary = 20000
        
        if let employee {
            employeeDao.update(employee)
        }
        print(employee?.name, employee?.salary)
    }
}
