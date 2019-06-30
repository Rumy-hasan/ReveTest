//
//  ViewController_Extentions.swift
//  ReveTest
//
//  Created by Paradox on 30/6/19.
//  Copyright © 2019 rumy. All rights reserved.
//

import UIKit

public extension UIViewController {
    func toggleSideMenuView() {
        sideMenuController()?.sideMenu?.toggleMenu()
    }
    
    func hideSideMenuView () {
        sideMenuController()?.sideMenu?.hideSideMenu()
    }
    
    func showSideMenuView() {
        sideMenuController()?.sideMenu?.showSideMenu()
    }
    
    func isSideMenuOpen() -> Bool {
        let sideMenuOpen = sideMenuController()?.sideMenu?.isMenuOpen
        return sideMenuOpen!
    }
    
    func fixSideMenuSize() {
        if let navController = navigationController as? BaseNavigationController {
            navController.sideMenu?.updateFrame()
        }
    }
    
    func sideMenuController() -> SideMenuProtocol? {
        var iteration: UIViewController? = parent
        if iteration == nil {
            return topMostController()
        }
        while iteration != nil {
            if iteration is SideMenuProtocol{
                return iteration as? SideMenuProtocol
            }else if (iteration?.parent != nil && iteration?.parent != iteration){
                iteration = iteration!.parent
            }else{
                iteration = nil
            }
        }
        return iteration as? SideMenuProtocol
    }
    
    
    func topMostController() -> SideMenuProtocol? {
        var topController : UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        if topController is UITabBarController{
            topController = (topController as! UITabBarController).selectedViewController
        }
        var lastMenuProtocol: SideMenuProtocol?
        while topController?.presentedViewController != nil {
            if(topController?.presentedViewController is SideMenuProtocol){
                lastMenuProtocol = topController?.presentedViewController as? SideMenuProtocol
            }
            topController = topController?.presentedViewController
        }
        if lastMenuProtocol != nil {
            return lastMenuProtocol
        }else{
            return topController as? SideMenuProtocol
        }
    }
    
}






































