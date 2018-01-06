//
//  ShowVinylDetailViewController.swift
//  projectVinylLibrary
//
//  Created by louis vallaey on 3/01/18.
//  Copyright © 2018 louis vallaey. All rights reserved.
//

import UIKit
import RealmSwift

class ShowVinylDetailViewController: UIViewController {
    var vinyl : Vinyl!
    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var artistLbl: UILabel!
    @IBOutlet weak var titleM: UILabel!
    @IBOutlet weak var genreM: UILabel!
    @IBOutlet weak var typeM: UILabel!
    @IBOutlet weak var releasedM: UILabel!
    override func viewDidLoad() {
        title = vinyl.title
        if vinyl.imageAd != ""{
            let dataimg = UserDefaults.standard.object(forKey: vinyl.imageAd)
             bannerImg.image = UIImage(data: dataimg as! Data)
        }else{
            bannerImg.image = #imageLiteral(resourceName: "vinyldef.png")
        }
        titleLbl.text = vinyl.title
        artistLbl.text = vinyl.artist
        titleM.text = vinyl.title
        genreM.text = vinyl.type
        typeM.text = vinyl.style
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        let dateString = formatter.string(from: vinyl.released)
        releasedM.text = dateString
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "showEditVinyl"?:
           let editVDController = segue.destination as! EditVinylViewController
            editVDController.vinyl = vinyl
        case "delVinyl"?:
            break
        default:
            fatalError("unknow segue(showVinylDetailctrl)")
        }
    }
    @IBAction func unwindFromEditVinyl(_ segue: UIStoryboardSegue) {
        switch  segue.identifier {
        case "editVinyl"?:
            let editVinylViewController = segue.source as! EditVinylViewController
            vinyl = editVinylViewController.vinyl
            titleLbl.text = vinyl.title
            artistLbl.text = vinyl.artist
            titleM.text = vinyl.title
            genreM.text = vinyl.type
            typeM.text = vinyl.style
            let formatter = DateFormatter()
            formatter.dateStyle = DateFormatter.Style.medium
            let dateString = formatter.string(from: vinyl.released)
            releasedM.text = dateString
        default:
            fatalError("unknow segue(showVinylDetailctrl Unwind)")
        }
        
    }
}
