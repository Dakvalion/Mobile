//
//  ButtonClicker.swift
//  FirstPractice
//
//  Created by Егор Бадмаев on 01.03.2024.
//

import UIKit

class ButtonClicker : UIViewController {
    
    
    @IBOutlet weak var buttonWho: UIButton!
    @IBOutlet weak var buttonMe: UIButton!
    @IBOutlet weak var helloWorld: UILabel!
    @IBOutlet weak var CheckBox: UISwitch!
    
    @IBAction func buttonMeAction(_ sender: Any) {
        helloWorld.text = "Это не я сделала"
        CheckBox.isOn = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonWho.addTarget(self, action: #selector(buttonWhoAmIAction), for: .touchUpInside)
    }
    
    @objc func buttonWhoAmIAction() {
        helloWorld.text = "Мой номер по списку №18"
        CheckBox.isOn = false
    }
    
}
