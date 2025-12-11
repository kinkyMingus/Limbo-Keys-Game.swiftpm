//
//  Key.swift
//  Limbo Keys Game
//
//  Created by JACKSON GERAMBIA on 12/9/25.
//

import Foundation
import SwiftUI

class Key : Identifiable {
    // number of key: 0-7
    let id : Int
    var image = "key"
    var x : Int = 0
    var y : Int = 0
    var isMoving: Bool = false
    
    init(id: Int, image: String = "key", x: Int = 0, y: Int = 0) {
        self.image = image
        self.x = x
        self.y = y
        self.id = id
    }
}
