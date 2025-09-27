//
//  item.swift
//  Todoey
//
//  Created by Lidiia Diachkovskaia on 9/15/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation

class Item: Encodable { //for encodable must have standard data types
    var title: String = ""
    var done: Bool = false
}
