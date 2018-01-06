//
//  Categorie.swift
//  projectVinylLibrary
//
//  Created by louis vallaey on 31/12/17.
//  Copyright © 2017 louis vallaey. All rights reserved.
//

import Foundation
import RealmSwift

class Categorie: Object {
    @objc dynamic var name = ""
    let vinyl = List<Vinyl>()
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}


