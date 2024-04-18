//
//  MusicPlayerViewController.swift
//  Lesson4
//
//  Created by Егор Бадмаев on 31.03.2024.
//

import UIKit
import SwiftUI

class MusicPlayerViewController: ViewController {
    var playerView = MusicPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBindingView(playerView)
    }
}
