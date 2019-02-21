//
//  ViewController.swift
//  lun
//
//  Created by Alyona Hulak on 2/18/19.
//  Copyright © 2019 Alyona Hulak. All rights reserved.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var peopleCollectionView: UICollectionView!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DBManager().storeModels {
            self.peopleCollectionView.reloadData()
        }
        configureView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let personCell = collectionView.dequeueReusableCell(withReuseIdentifier: "personCollectionViewCell", for: indexPath) as! PersonCollectionViewCell
        
        if self.realm.objects(StoredPerson.self).count != 0 {
            let photoId = self.realm.object(ofType: StoredPerson.self, forPrimaryKey: 1)?.profile_image_id
            let photoLink = self.realm.object(ofType: StoredImages.self, forPrimaryKey: photoId)?.link
            let url = URL(string: photoLink!)
            let data = try? Data(contentsOf: url!)
            let phone = self.realm.object(ofType: StoredPerson.self, forPrimaryKey: 1)?.phone
            let name = self.realm.object(ofType: StoredPerson.self, forPrimaryKey: 1)?.name
            personCell.displayContent(photo: UIImage(data: data!)!, name: name!, phone: phone!)
        }
        return personCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mapVC = mainStoryboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        mapVC.lat = (self.realm.object(ofType: StoredPerson.self, forPrimaryKey: 1)?.lat)!
        mapVC.lng = (self.realm.object(ofType: StoredPerson.self, forPrimaryKey: 1)?.lng)!
        mapVC.name = (self.realm.object(ofType: StoredPerson.self, forPrimaryKey: 1)?.name)!
        self.navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func configureView() {
        updateCellSpacing()
        let gradient = CAGradientLayer(layer: CAGradientLayer.self)
        gradient.frame = (navigationController?.navigationBar.bounds)!
        gradient.colors = [#colorLiteral(red: 1, green: 0.4952832675, blue: 0.1673531673, alpha: 1).cgColor, #colorLiteral(red: 1, green: 0.8821477491, blue: 0.2560303466, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        if let image = getImageFrom(gradientLayer: gradient) {
            navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        }
    }
    
    func updateCellSpacing() {
        let width = self.view.bounds.width
        let numberOfCellsInRaw = CGFloat(Int(width / 159))
        let widthForCells = CGFloat(numberOfCellsInRaw * 159)
        let halfCellSpacing = (width - widthForCells) / (numberOfCellsInRaw * 2)
        peopleCollectionView.contentInset =  UIEdgeInsets(top: halfCellSpacing, left: halfCellSpacing, bottom: halfCellSpacing, right: halfCellSpacing)
        
    }
    
    func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }

}

