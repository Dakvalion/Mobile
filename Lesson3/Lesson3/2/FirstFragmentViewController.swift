//
//  FirstFragmentViewController.swift
//  Lesson3
//
//  Created by Дарья Никитина on 27.03.2024.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredDisplayMode = .oneBesideSecondary
        delegate = self
    }
}

class FirstFragmentViewController: UIViewController, UISplitViewControllerDelegate {
    @IBOutlet weak var secondFragmentButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondFragmentButton.isHidden = UIDevice.current.orientation.isLandscape
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        secondFragmentButton.isHidden = UIDevice.current.orientation.isLandscape
    }
    
    @IBAction func secondFragmentButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SecondFragment")
//        let navigation = UINavigationController(rootViewController: viewController)
//        splitViewController?.showDetailViewController(navigation, sender: nil)
        splitViewController?.showDetailViewController(viewController, sender: nil)
    }
}

class SecondFragmentViewController: UIViewController {
}
