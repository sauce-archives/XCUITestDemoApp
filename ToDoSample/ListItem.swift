//
//  ListItem.swift
//  ToDoSample
//
//  Created by David on 17.04.18.
//  Copyright © 2018 Saucelabs. All rights reserved.
//

import UIKit

class ListItem : Equatable, Codable {
    
    enum Color: Int, Codable {
        case green
        case red
    }
    
    let title: String
    var color: Color?
    
    init(title: String) {
        self.title = title
    }
    
    static func == (lhs: ListItem, rhs: ListItem) -> Bool {
        return lhs.title == rhs.title
    }
    
}
