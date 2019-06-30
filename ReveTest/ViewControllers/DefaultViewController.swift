//
//  ViewController.swift
//  ReveTest
//
//  Created by Paradox on 30/6/19.
//  Copyright © 2019 rumy. All rights reserved.
//

import UIKit

class DefaultViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //if needed we can use
        //self.sideMenuController()?.sideMenu?.delegate = self
    }
    
    @IBAction func toggleClicked(_ sender: Any) {
        toggleSideMenuView()
    }
}

/*
extension DefaultViewController:SideMenuDelegate{
    func sideMenuWillOpen() {
        <#code#>
    }
    
    func sideMenuWillClose() {
        <#code#>
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        <#code#>
    }
    
    func sideMenuDidOpen() {
        <#code#>
    }
    
    func sideMenuDidClose() {
        <#code#>
    }
    
}
 */
