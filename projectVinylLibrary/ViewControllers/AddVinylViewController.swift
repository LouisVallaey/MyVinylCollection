//
//  AddVinylViewController.swift
//  projectVinylLibrary
//
//  Created by louis vallaey on 3/01/18.
//  Copyright © 2018 louis vallaey. All rights reserved.
//

import UIKit

class AddVinylViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    @IBOutlet weak var titleTxt: UITextField!
    @IBOutlet weak var artistTxt: UITextField!
    @IBOutlet weak var typeTxt: UITextField!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var chngBtn: UIButton!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    var vinyl : Vinyl?
    var imagectrData:NSData?
    override func viewDidLoad() {
        titleTxt.attributedPlaceholder = NSAttributedString(string: "Titel",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        artistTxt.attributedPlaceholder = NSAttributedString(string: "artist",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        typeTxt.attributedPlaceholder = NSAttributedString(string: "Genre",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        vinyl = Vinyl(title: titleTxt.text!, artist: artistTxt.text!, type: typeTxt.text!, imageAd:"")
        if imagectrData != nil{
            UserDefaults.standard.set(imagectrData, forKey: titleTxt.text!)
            vinyl?.imageAd = titleTxt.text!
        }
    }
    
    @IBAction func saveVinyl(_ sender: Any) {
        performSegue(withIdentifier: "addVinyl", sender: self)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        let imagectrl = UIImagePickerController()
        imagectrl.delegate = self
        //deploy (camera wnr ik test op Iphone)
        //imagectrl.sourceType = UIImagePickerControllerSourceType.camera
        //dev (photolibrary bij simulator)
        imagectrl.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagectrl.allowsEditing = false
        self.present(imagectrl,animated: true){}
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        //controle of image is meegegeven (moest er een fout zijn met de image)
        if let imagectr = info[UIImagePickerControllerOriginalImage] as? UIImage{
             imagectrData = UIImagePNGRepresentation(imagectr)! as NSData
            //andere manier zoeken zonder defaults...
            image.image = imagectr
            chngBtn.setTitle("Change Photo", for: .normal)
        }
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func textBoxTitle(_ sender: Any) {
        if titleTxt.text == "" {
            saveBtn.isEnabled = false
        } else {
            saveBtn.isEnabled = true
        }
    }
}
