//
//  ShowVinylDetailViewController.swift
//  projectVinylLibrary
//
//  Created by louis vallaey on 3/01/18.
//  Copyright © 2018 louis vallaey. All rights reserved.
//

import UIKit
import RealmSwift

class ShowVinylDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bannerImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var artistLbl: UILabel!
    @IBOutlet weak var titleM: UILabel!
    @IBOutlet weak var genreM: UILabel!
    @IBOutlet weak var typeM: UILabel!
    @IBOutlet weak var releasedM: UILabel!
    var vinyl : Vinyl!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
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
        case "showAddSong"?:
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
    @IBAction func unwindFromAddSong(_ segue: UIStoryboardSegue) {
        switch  segue.identifier {
        case "addSong"?:
            let addSVController = segue.source as! AddSongViewController
            try! Realm().write {
                vinyl.song.append(addSVController.song!)
            }
            tableView.insertRows(at: [IndexPath(row: (vinyl.song.count) - 1, section: 0)], with: .automatic)
        default:
            fatalError("unknow segue(unwindaddsong Unwind)")
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vinyl.song.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as! SongTableViewCell
        cell.nameLbl.text = vinyl.song[indexPath.row].name
        cell.sideLbl.text = vinyl.song[indexPath.row].side
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            let song = self.vinyl.song[indexPath.row]
            let realm = try! Realm()
            try! realm.write {
                realm.delete(song)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}
