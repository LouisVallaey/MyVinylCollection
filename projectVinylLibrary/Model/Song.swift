//
//  Song.swift
//  projectVinylLibrary
//
//  Created by louis vallaey on 7/01/18.
//  Copyright © 2018 louis vallaey. All rights reserved.
//

import Foundation
import RealmSwift

class Song: Object {
    @objc dynamic var name = ""
    @objc dynamic var side = ""
    convenience init(name : String, side : String) {
        self.init()
        self.name = name
        self.side = side
    }
}
