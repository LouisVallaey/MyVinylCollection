//
//  CategorieViewController.swift
//  projectVinylLibrary
//
//  Created by louis vallaey on 31/12/17.
//  Copyright © 2017 louis vallaey. All rights reserved.
//
import RealmSwift
import UIKit

class CategorieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var tableView: UITableView!
    var categories: Results<Categorie>?
    override func viewDidLoad() {
        categories = try! Realm().objects(Categorie.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showAddCat"?:
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
        case "showVinyl"?:
            self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
            let vinylViewController = segue.destination as! VinylViewController
            let selectCat = tableView.indexPathForSelectedRow!
            vinylViewController.categorie = categories![selectCat.row]
            tableView.deselectRow(at: selectCat, animated: true)
        default:
           fatalError("Unknown segue (CatViewctrlPrep)")
        }
        
    }
    @IBAction func unwindAddCategorie(_ segue: UIStoryboardSegue) {
        let addCatCon = segue.source as! AddCategorieViewController
        let realm = try! Realm()
        try! realm.write {
            realm.add(addCatCon.categorie!)
        }
        tableView.insertRows(at: [IndexPath(row: (categories?.count)! - 1, section: 0)], with: .automatic)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories!.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategorieCell", for: indexPath) as! CategorieCell
        cell.viewCell.layer.cornerRadius = 5
        cell.nameLbl.text = categories![indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            let categorie = self.categories![indexPath.row]
            let realm = try! Realm()
            try! realm.write {
                realm.delete(categorie)
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}

