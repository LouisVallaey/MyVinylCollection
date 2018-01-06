//
//  EditVinylViewController.swift
//  projectVinylLibrary
//
//  Created by louis vallaey on 6/01/18.
//  Copyright © 2018 louis vallaey. All rights reserved.
//
import RealmSwift
import UIKit

class EditVinylViewController: UIViewController {
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var artistTxt: UITextField!
    @IBOutlet weak var genreTxt: UITextField!
    @IBOutlet weak var styleTxt: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var vinyl : Vinyl!
    override func viewDidLoad() {
        titleTxt.attributedPlaceholder = NSAttributedString(string: "Title",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        artistTxt.attributedPlaceholder = NSAttributedString(string: "Artist",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        genreTxt.attributedPlaceholder = NSAttributedString(string: "Genre",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        styleTxt.attributedPlaceholder = NSAttributedString(string: "Type",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        datePicker.setValue(UIColor.lightGray, forKeyPath: "textColor")
        if vinyl.imageAd != ""{
            let dataimg = UserDefaults.standard.object(forKey: (vinyl?.imageAd)!)
            image.image = UIImage(data: dataimg as! Data)
        }else{
            image.image = #imageLiteral(resourceName: "vinyldef.png")
        }
        titleTxt.text = vinyl.title
        artistTxt.text = vinyl.artist
        genreTxt.text = vinyl.type
        styleTxt.text = vinyl.style
        datePicker.date = vinyl.released
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        try! Realm().write {
            vinyl.title = titleTxt.text!
            vinyl.artist = artistTxt.text!
            vinyl.type = genreTxt.text!
            vinyl.style = styleTxt.text!
            vinyl.released = datePicker.date
        }
    }
}
