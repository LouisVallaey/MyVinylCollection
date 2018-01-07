//
//  AddSongViewController.swift
//  projectVinylLibrary
//
//  Created by louis vallaey on 7/01/18.
//  Copyright © 2018 louis vallaey. All rights reserved.
//

import UIKit

class AddSongViewController: UIViewController {
    @IBOutlet weak var nametxt: UITextField!
    @IBOutlet weak var pick: UISegmentedControl!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    var song : Song?
    var side : String = "A-Side"
    override func viewDidLoad() {
        nametxt.attributedPlaceholder = NSAttributedString(string: "Name",attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        song = Song.init(name: nametxt.text!, side: side)
    }
    
    @IBAction func indexchange(_ sender: Any) {
        switch pick.selectedSegmentIndex
        {
        case 0:
            side = "A-Side";
        case 1:
            side = "B-Side";
        default:
            break
        }
    }
    @IBAction func check(_ sender: Any) {
        if nametxt.text == "" {
            saveBtn.isEnabled = false
        } else {
            saveBtn.isEnabled = true
        }
    }
    
}
