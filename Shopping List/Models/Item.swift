//
//  Todo.swift
//  Shopping List
//
//  Created by Sebastian Banks on 3/25/22.
//

import Foundation

class Item: Codable {
    let itemName: String
    var isDone: Bool
    
    init(itemName: String, isDone: Bool = false) {
        self.itemName = itemName
        self.isDone = isDone
    }
}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.itemName == rhs.itemName && lhs.isDone == rhs.isDone
    }
}


