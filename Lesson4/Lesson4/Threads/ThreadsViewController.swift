//
//  ThreadsViewController.swift
//  Lesson4
//
//  Created by Егор Бадмаев on 13.04.2024.
//

import UIKit
import SwiftUI

class ThreadsViewController: ViewController {
    var threadsView = ThreadsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBindingView(threadsView)
    }
}
