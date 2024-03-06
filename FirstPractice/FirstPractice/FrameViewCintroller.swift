//
//  FrameViewCintroller.swift
//  FirstPractice
//
//  Created by Егор Бадмаев on 29.02.2024.
//

import UIKit
class FrameViewCintroller : UIViewController {
    
    var label: UILabel?
    var button: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabel()
        setupButton()
    }
    
    private func setupLabel() {
        let label = UILabel()
        
        label.text = "Hello world!"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        view.addSubview(label)
        self.label = label
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        performLayout()
    }
    
    private func setupButton() {
        let button = UIButton()
        
        button.setTitle("Click", for: UIControl.State.normal)
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 8
        view.addSubview(button)
        self.button = button
        
    }
    
    private func performLayout() {
        guard let label else { return }
        
        let labelWidth: CGFloat = 110
        let labelHeight: CGFloat = 50
        let labelX = view.center.x - (labelWidth / 2)
        let labelY = view.center.y - (labelHeight / 2)
        
        label.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        
        guard let button else { return }
        
        let butWidth: CGFloat = 120
        let butHeight: CGFloat = 30
        let butX = label.frame.minX
        let butY = label.frame.maxY
        
        button.frame = CGRect(x: butX, y: butY, width: butWidth, height: butHeight)
        
    }
    
    
    
}
