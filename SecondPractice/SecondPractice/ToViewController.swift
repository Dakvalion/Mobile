//
//  ToViewController.swift
//  SecondPractice
//
//  Created by Дарья Никитина on 12.03.2024.
//

import UIKit

class ToViewController: UIViewController {
    
    var labelText: String = ""
    
    @IBOutlet weak var label: UILabel!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("init - ToViewController")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        print("loadView - ToViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad - ToViewController")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear - ToViewController")
        
        if !labelText.isEmpty {
            label.text = labelText
        }
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print("viewIsAppearing - ToViewController")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear - ToViewController")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews - ToViewController")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews - ToViewController")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear - ToViewController")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear - ToViewController")
    }
    
    deinit {
        print("deinit - ToViewController")
    }
}
