//
//  Protocols.swift
//  ReveTest
//
//  Created by Paradox on 30/6/19.
//  Copyright © 2019 rumy. All rights reserved.
//

import UIKit

//MARK:- responsible for side menu update or any change.it will help view controller to update the current state of side menu
protocol SideMenuDelegate: class {
    func sideMenuWillOpen()
    func sideMenuWillClose()
    func sideMenuShouldOpenSideMenu () -> Bool
    func sideMenuDidOpen()
    func sideMenuDidClose()
}

// MARK:- responsible for set main content 
public protocol SideMenuProtocol {
    var sideMenu: SideMenu? {get}
    func setContent(of viewController: UIViewController)
}

protocol cummunicateWithParent: class{
    func changeParntView()
}
