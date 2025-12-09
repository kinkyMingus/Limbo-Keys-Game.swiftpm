//
//  Key.swift
//  Limbo Keys Game
//
//  Created by JACKSON GERAMBIA on 12/9/25.
//

import Foundation
import SwiftUI

class Key {
    var image = "key"
    var x : Int
    var y : Int
    // number of key: 0-7
    var id : Int
    
    init(image: String = "key", x: Int, y: Int, id: Int) {
        self.image = image
        self.x = x
        self.y = y
        self.id = id
    }
}
