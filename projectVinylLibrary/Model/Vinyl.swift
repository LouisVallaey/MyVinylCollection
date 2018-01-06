//
//  Vinyl.swift
//  projectVinylLibrary
//
//  Created by louis vallaey on 31/12/17.
//  Copyright © 2017 louis vallaey. All rights reserved.
//

import Foundation
import RealmSwift

class Vinyl: Object {
    @objc dynamic var title = ""
    @objc dynamic var artist = ""
    @objc dynamic var type = ""
    @objc dynamic var released = Date()
    @objc dynamic var style = ""
    @objc dynamic var imageAd = ""
    
    convenience init(title: String , artist: String, type: String, imageAd: String) {
        self.init()
        self.title = title
        self.artist = artist
        self.type = type
        self.imageAd = imageAd
    }
}
