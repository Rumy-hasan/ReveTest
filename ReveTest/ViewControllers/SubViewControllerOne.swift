//
//  SubViewControllerOne.swift
//  ReveTest
//
//  Created by Paradox on 30/6/19.
//  Copyright © 2019 rumy. All rights reserved.
//

import UIKit

class SubViewControllerOne: UIViewController {

    @IBOutlet weak var testCV: UICollectionView!
    
    weak var delegateForContactwithParent : cummunicateWithParent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


extension SubViewControllerOne:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subonetest", for: indexPath) as? SubOneTestCell else {
            return UICollectionViewCell()
        }
        cell.img.image = UIImage(named: "te")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 10) / 2, height: (collectionView.frame.width - 10) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegateForContactwithParent?.changeParntView()
    }
}
