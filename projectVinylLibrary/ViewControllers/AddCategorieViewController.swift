//
//  AddCategorieViewController.swift
//  projectVinylLibrary
//
//  Created by louis vallaey on 2/01/18.
//  Copyright © 2018 louis vallaey. All rights reserved.
//

import UIKit

class AddCategorieViewController: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textBox: UITextField!
    var categorie : Categorie?
    override func viewDidLoad() {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        categorie = Categorie(name: textBox.text!)
    }
    @IBAction func saveCat(_ sender: Any) {
        performSegue(withIdentifier: "addCat", sender: self)
    }
    @IBAction func textBoxChange(_ sender: Any) {
        if textBox.text == "" {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
}

