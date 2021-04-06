//
//  TutorialPageViewController.swift
//  PageViewController Simple Example
//
//  Created by Dhananjay.Mohnot on 04/04/21.
//  Copyright © 2021 Dhananjay.Mohnot. All rights reserved.
//
//  Source: https://spin.atomicobject.com/2015/12/23/swift-uipageviewcontroller-tutorial/

import UIKit

class TutorialPageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [self.newColoredViewController("Green"), self.newColoredViewController("Red"), self.newColoredViewController("Blue")]
    }()
    
    private func newColoredViewController(_ color: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(color)ViewController")
    }
}

// MARK: -
extension TutorialPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            // User is on the first view controller and swiped left to loop to the last view controller.
            return orderedViewControllers.last //nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            // User is on the last view controller and swiped right to loop to the first view controller.
            return orderedViewControllers.first //nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
