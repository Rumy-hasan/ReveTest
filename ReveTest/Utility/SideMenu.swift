//
//  SideMenu.swift
//  ReveTest
//
//  Created by Paradox on 30/6/19.
//  Copyright © 2019 rumy. All rights reserved.
//

import UIKit

public class SideMenu:NSObject{
    var menuViewController : UIViewController! // menu controller holder
    let sideMenuContainerView =  UIView()  // menu container view
    open var menuWidth : CGFloat = 160.0 {
        didSet {
            needUpdateApperance = true
            updateSideMenuApperanceIfNeeded()
            updateFrame()
        }
    }
    
    
    var sourceView:UIView!    // main view holder
    
    var needUpdateApperance : Bool = false
    
    var panRecognizer : UIPanGestureRecognizer?
    weak var delegate : SideMenuDelegate?
    
    var isMenuOpen : Bool = false // detect the menu is open or not
    var animationDuration = 0.4 // default time duration of animation
    
    var allowLeftSwipe : Bool = true
    var allowRightSwipe : Bool = true
    var allowPanGesture : Bool = true
    
    
    
    public init(sourceView: UIView) {
        super.init()
        self.sourceView = sourceView
        setupMenuView()
        setupGesture()
    }
    
    // MARK:- add menu controller to side menu container
    public convenience init(sourceView: UIView, menuViewController: UIViewController) {
        self.init(sourceView: sourceView)
        self.menuViewController = menuViewController
        menuViewController.view.frame = sideMenuContainerView.bounds
        menuViewController.view.autoresizingMask =  [.flexibleHeight, .flexibleWidth]
        sideMenuContainerView.addSubview(menuViewController.view)
    }
    
    // gesture initialization
    func setupGesture() {
        self.panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        self.panRecognizer?.delegate = self
        sourceView.addGestureRecognizer(panRecognizer!)
        
        let rightSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        rightSwipeGestureRecognizer.delegate = self
        rightSwipeGestureRecognizer.direction =  .right
        
        let leftSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        leftSwipeGestureRecognizer.delegate = self
        leftSwipeGestureRecognizer.direction = .left
        
        sideMenuContainerView.addGestureRecognizer(leftSwipeGestureRecognizer)
        sourceView.addGestureRecognizer(rightSwipeGestureRecognizer)
    }
    
    
    //MARK:- update side menu
    func setupMenuView(){
        updateFrame()
        
        sideMenuContainerView.backgroundColor = UIColor.clear
        sideMenuContainerView.clipsToBounds = false
        sideMenuContainerView.layer.masksToBounds = false
        
        sideMenuContainerView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        
        sideMenuContainerView.layer.shadowRadius = 1.0
        sideMenuContainerView.layer.shadowOpacity = 0.125
        sideMenuContainerView.layer.shadowPath = UIBezierPath(rect: sideMenuContainerView.bounds).cgPath
        
        sourceView.addSubview(sideMenuContainerView)
    }
    
    
    // it will update side menu frame
    func updateSideMenuApperanceIfNeeded () {
        if (needUpdateApperance) {
            var frame = sideMenuContainerView.frame
            frame.size.width = menuWidth
            sideMenuContainerView.frame = frame
            sideMenuContainerView.layer.shadowPath = UIBezierPath(rect: sideMenuContainerView.bounds).cgPath
            needUpdateApperance = false
        }
    }
    
    func updateFrame() {
        let menuFrame = CGRect( x: isMenuOpen ? 0 : -menuWidth-1.0, y: sourceView.frame.origin.y, width: menuWidth, height: sourceView.frame.size.height)
        sideMenuContainerView.frame = menuFrame
    }
    
    
    //MARK:- responsible for reverse the side menu
    private func toggleMenu (_ shouldOpen: Bool) {
        if shouldOpen, delegate?.sideMenuShouldOpenSideMenu() == false {
            return
        }
        updateSideMenuApperanceIfNeeded()
        isMenuOpen = shouldOpen
        var destFrame :CGRect
        if shouldOpen{
            destFrame = CGRect(x: 0, y: 0, width: menuWidth, height: sourceView.frame.size.height)
        }else{
            destFrame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: sourceView.frame.size.height)
        }
        
        UIView.animate(withDuration: animationDuration, animations: {[weak self] () -> Void in
            self?.sideMenuContainerView.frame = destFrame
            }, completion: { [weak self] (Bool) -> Void in
                guard let strongSelf = self else { return }
                if (strongSelf.isMenuOpen) {
                    strongSelf.delegate?.sideMenuDidOpen()
                } else {
                    strongSelf.delegate?.sideMenuDidClose()
                }
        })
        
        if (shouldOpen) {
            delegate?.sideMenuWillOpen()
        } else {
            delegate?.sideMenuWillClose()
        }
    }
    
   
    func toggleMenu () {
        if (isMenuOpen) {
            toggleMenu(false)
        }
        else {
            updateSideMenuApperanceIfNeeded()
            toggleMenu(true)
        }
    }
    
    func showSideMenu () {
        if (!isMenuOpen) {
            toggleMenu(true)
        }
    }
    
    func hideSideMenu () {
        if (isMenuOpen) {
            toggleMenu(false)
        }
    }
    
    
    //MARK:- gesture controller
    
    @objc func handlePan(_ recognizer : UIPanGestureRecognizer){
        
        let leftToRight = recognizer.velocity(in: recognizer.view).x > 0
        
        switch recognizer.state {
        case .began:
            
            break
            
        case .changed:
            
            let translation = recognizer.translation(in: sourceView).x
            let xPoint : CGFloat = sideMenuContainerView.center.x + translation + 1 * menuWidth / 2
            
            if xPoint <= 0 || xPoint > sideMenuContainerView.frame.width {
                return
            }
            
            
            sideMenuContainerView.center.x = sideMenuContainerView.center.x + translation
            recognizer.setTranslation(CGPoint.zero, in: sourceView)
            
        default:
            let shouldClose = !leftToRight && sideMenuContainerView.frame.maxX < menuWidth
            
            toggleMenu(!shouldClose)
            
        }
    }
    
    @objc internal func handleGesture(_ gesture: UISwipeGestureRecognizer) {
        toggleMenu((gesture.direction == .right))
    }
    
}





extension SideMenu:UIGestureRecognizerDelegate{
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if delegate?.sideMenuShouldOpenSideMenu() == false {
            return false
        }
        
        if gestureRecognizer is UISwipeGestureRecognizer {
            let swipeGestureRecognizer = gestureRecognizer as! UISwipeGestureRecognizer
            if !allowLeftSwipe {
                if swipeGestureRecognizer.direction == .left {
                    return false
                }
            }
            
            if !allowRightSwipe {
                if swipeGestureRecognizer.direction == .right {
                    return false
                }
            }
        } else if gestureRecognizer.isEqual(panRecognizer) {
            if allowPanGesture == false {
                return false
            }
            let touchPosition = gestureRecognizer.location(ofTouch: 0, in: sourceView)
            
            if isMenuOpen {
                if touchPosition.x < menuWidth {
                    return true
                }
            }
            else {
                if touchPosition.x < 25 {
                    return true
                }
            }
            return false
        }
        return true
    }
    
}
