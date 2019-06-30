//
//  BaseNavigationController.swift
//  ReveTest
//
//  Created by Paradox on 30/6/19.
//  Copyright © 2019 rumy. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    var sideMenu : SideMenu?
    var sideMenuAnimationType : SideMenuAnimation = .default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.basicSetup()
    }
    
    public init( menuViewController: UIViewController, contentViewController: UIViewController?) {
        super.init(nibName: nil, bundle: nil)
        
        if (contentViewController != nil) {
            self.viewControllers = [contentViewController!]
        }
        
        sideMenu = SideMenu(sourceView: self.view, menuViewController: menuViewController)
        view.bringSubviewToFront(navigationBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func basicSetup() {
        let tableViewController = SideMenuTableViewController()
        sideMenu = SideMenu(sourceView: self.view, menuViewController: tableViewController)
        sideMenu?.delegate = self
        sideMenu?.menuWidth = 180
        view.bringSubviewToFront(navigationBar)
    }
    
}


extension BaseNavigationController: SideMenuProtocol{
    func setContent(of viewController: UIViewController) {
        self.sideMenu?.toggleMenu()
        switch sideMenuAnimationType {
        case .none:
            self.viewControllers = [viewController]
            break
        default:
            viewController.navigationItem.hidesBackButton = true
            self.setViewControllers([viewController], animated: true)
            break
        }
    }
}

//MARK:-  work if needed
extension BaseNavigationController: SideMenuDelegate{
    func sideMenuWillOpen() {
        //
    }
    
    func sideMenuWillClose() {
        //
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        return true
    }
    
    func sideMenuDidOpen() {
        //
    }
    
    func sideMenuDidClose() {
        //
    }
}
