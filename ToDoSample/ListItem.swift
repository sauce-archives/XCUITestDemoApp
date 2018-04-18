//
//  ListItem.swift
//  ToDoSample
//
//  Created by David on 17.04.18.
//  Copyright © 2018 Saucelabs. All rights reserved.
//

import UIKit

class ListItem : Equatable, Codable {
    
    let title: String
    var done: Bool = false
    
    init(title: String) {
        self.title = title
    }
    
    static func == (lhs: ListItem, rhs: ListItem) -> Bool {
        return lhs.title == rhs.title
    }
    
}
