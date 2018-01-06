//
//  AllRealmObjects.swift
//  projectVinylLibrary
//
//  Created by louis vallaey on 31/12/17.
//  Copyright © 2017 louis vallaey. All rights reserved.
//

import Foundation
import RealmSwift

class Human : Object{
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var race = ""
}
