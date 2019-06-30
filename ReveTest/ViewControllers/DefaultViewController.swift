//
//  ViewController.swift
//  ReveTest
//
//  Created by Paradox on 30/6/19.
//  Copyright © 2019 rumy. All rights reserved.
//

import UIKit

class DefaultViewController: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var subViewsContainerView: UIView!
    
    // initialization of view controller
    lazy var subOneVC: SubViewControllerOne = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier: "one") as! SubViewControllerOne
        self.addVcAs(child: vc)
        return vc
    }()
    lazy var subTowVC: SubViewControllerTow = {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var vc = storyboard.instantiateViewController(withIdentifier: "tow") as! SubViewControllerTow
        self.addVcAs(child: vc)
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //if needed we can use
        //self.sideMenuController()?.sideMenu?.delegate = self
        
        self.segment.selectedSegmentIndex = 0
        self.updateView()
    }
    
    @IBAction func toggleClicked(_ sender: Any) {
        toggleSideMenuView()
    }
    
    @IBAction func didSegmentValueChange(_ sender: Any) {
        self.updateView()
    }
    
}

//MARK: sub view work here
extension DefaultViewController{
    func updateView() {
        subOneVC.view.isHidden = !(segment.selectedSegmentIndex == 0)
        subTowVC.view.isHidden = !(segment.selectedSegmentIndex == 1)
    }
    
    func addVcAs(child vc: UIViewController) {
        addChild(vc)
        self.subViewsContainerView.addSubview(vc.view)
        vc.view.frame = self.subViewsContainerView.bounds
            
            //CGRect(x: 10, y: 200, width: self.view.frame.width - 20, height: self.view.frame.height - 210)
        vc.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        vc.didMove(toParent: self)
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
