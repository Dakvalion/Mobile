//
//  FirstFragmentViewController.swift
//  Lesson3
//
//  Created by Егор Бадмаев on 27.03.2024.
//

import UIKit

class SplitViewController: UISplitViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        preferredDisplayMode = .oneBesideSecondary
//        delegate = self
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "FirstFragment") as? FirstFragmentViewController else { return }
//        delegate = viewController
//        preferredDisplayMode = .allVisible
    }
}

class SplitVC: UISplitViewController, UISplitViewControllerDelegate {
    
    private lazy var primary = UINavigationController(rootViewController: MasterViewController())
    private lazy var details = UINavigationController(rootViewController: DetailViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        preferredDisplayMode = .allVisible
        delegate = self
        viewControllers = [
            primary,
            details
        ]
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        
        guard
            let primary = primaryViewController as? UINavigationController,
            let detail = secondaryViewController as? UINavigationController
        else {
            return false
        }
        
        let viewControllers = detail.popToRootViewController(animated: false)
        if let viewControllers {
            primary.viewControllers.append(contentsOf: viewControllers)
        }
        
        return true
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        
        guard let primary = primaryViewController as? UINavigationController else { return nil }
        
        self.details.popToRootViewController(animated: false)

        if let viewControllers = primary.popToRootViewController(animated: false) {
            self.details.viewControllers.append(contentsOf: viewControllers)
        }

        return self.details
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        showDetail vc: UIViewController,
        sender: Any?
    ) -> Bool {
        
        if splitViewController.isCollapsed {
            primary.pushViewController(vc, animated: true)
        } else {
            details.setViewControllers([vc], animated: false)
        }
        return true
    }
}

class MasterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }
}

class DetailsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
}


class FirstFragmentViewController: UIViewController, UISplitViewControllerDelegate {
    
    @IBAction func secondFragmentButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SecondFragment")
        let navigation = UINavigationController(rootViewController: viewController)
        splitViewController?.showDetailViewController(navigation, sender: nil)
    }
}

class SecondFragmentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationController?.navigationItem.leftItemsSupplementBackButton = true
//        navigationController?.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        
//        if let splitViewController {
//            if let navigationController = splitViewController.viewControllers.last as? UINavigationController {
//                navigationController.topViewController?.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
//            }
//        }
    }
}
