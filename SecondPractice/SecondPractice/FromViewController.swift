//
//  ViewController.swift
//  SecondPractice
//
//  Created by Дарья Никитина on 12.03.2024.
//

import UIKit

class FromViewController: UIViewController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print("init - FromViewController")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        print("loadView - FromViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad - FromViewController")
    }
    
    @IBAction func clickMeButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let toViewController = storyboard.instantiateViewController(withIdentifier: "ToView") as? ToViewController else { return }
        toViewController.labelText = "This is second activity, but provided from FROM activity"
        present(toViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear - FromViewController")
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print("viewIsAppearing - FromViewController")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear - FromViewController")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews - FromViewController")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews - FromViewController")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear - FromViewController")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear - FromViewController")
    }
    
    deinit {
        print("deinit - FromViewController")
    }
}
