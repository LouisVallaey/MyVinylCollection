//
//  VinylViewController.swift
//  projectVinylLibrary
//
//  Created by louis vallaey on 2/01/18.
//  Copyright © 2018 louis vallaey. All rights reserved.
//

import UIKit
import RealmSwift
class VinylViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var collectionView: UICollectionView!
    var categorie : Categorie!
    override func viewDidLoad() {
        title = categorie.name
        collectionView.delegate = self
        collectionView.dataSource = self
    // custom layout, 3 items naast elkaar zonder margin.
        let itemSize = UIScreen.main.bounds.width/3
        let ly = UICollectionViewFlowLayout()
        ly.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        ly.itemSize = CGSize(width: itemSize, height: itemSize)
        ly.minimumInteritemSpacing = 0
        ly.minimumLineSpacing = 0
        collectionView.collectionViewLayout = ly
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showAddVinyl"?:
            break
        case "showVinylDetail"?:
            let showVinylDetailCtrl = segue.destination as! ShowVinylDetailViewController
            let selectVinyl = collectionView.indexPathsForSelectedItems?.first
            showVinylDetailCtrl.vinyl = categorie.vinyl[(selectVinyl?.item)!]
        case "showVinylDetailR"?:
            let showVinylDetailCtrl = segue.destination as! ShowVinylDetailViewController
            showVinylDetailCtrl.vinyl = categorie.vinyl[Int(arc4random_uniform(UInt32(categorie.vinyl.count)))]
        default:
            fatalError("Unknown segue")
        }
    }
    
    @IBAction func unwindFromAddVinyl(_ segue: UIStoryboardSegue) {
         switch segue.identifier {
         case "addVinyl"?:
                let addVinylViewController = segue.source as! AddVinylViewController
                let vinyl = addVinylViewController.vinyl
                try! Realm().write {
                categorie.vinyl.append(vinyl!)
                }
                let count = categorie.vinyl.count
                collectionView.insertItems(at: [IndexPath(item: count - 1, section:0)])
         default:
            fatalError("Unknown segue")
        }
        
    }
    @IBAction func unwindFromVinylDetail(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "delVinyl"?:
            let showVinylDetailController = segue.source as! ShowVinylDetailViewController
            let vinyl = showVinylDetailController.vinyl
            let realm = try! Realm()
            try! realm.write {
                realm.delete(vinyl!)
            }
            self.collectionView.reloadData()
        default:
            fatalError("Unknown segue")
        }
        
    }
    //aantal views nodig
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categorie.vinyl.count
    }
    //populate views
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "vinylCell", for: indexPath) as! VinylCell
        cell.nameVinylLbl.text = categorie.vinyl[indexPath.row].title
        cell.artistLbl.text = categorie.vinyl[indexPath.row].artist
        let dataimg = UserDefaults.standard.object(forKey: categorie.vinyl[indexPath.row].imageAd)
        if categorie.vinyl[indexPath.row].imageAd != ""{
           cell.imagecell.image = UIImage(data: dataimg as! Data)
        }else{
            cell.imagecell.image = #imageLiteral(resourceName: "vinyldef.png")
        }
        cell.sendSubview(toBack: cell.imagecell)
        return cell
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if event?.subtype == UIEventSubtype.motionShake{
            performSegue(withIdentifier: "showVinylDetailR", sender: nil)
        }
    }
}
