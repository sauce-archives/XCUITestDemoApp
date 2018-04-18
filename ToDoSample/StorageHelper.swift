//
//  StorageHelper.swift
//  ToDoSample
//
//  Created by David on 18.04.18.
//  Copyright © 2018 Saucelabs. All rights reserved.
//

import Foundation

private let LIST_ITEMS_KEY = "listItems"

func store(items: [ListItem]) {
    let url = fileURL()

    let encoder = JSONEncoder()
    let data = try! encoder.encode(items)
    
    try! data.write(to: url)
}

func loadItems() -> [ListItem] {
    let url = fileURL()
    
    do {
        let data = try Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        let items = try! decoder.decode([ListItem].self, from: data)
        
        return items
    } catch {
        return []
    }
}

func update(item: ListItem) {
    var items = loadItems()
    
    guard let idx = items.index(of: item) else {
        return
    }
    items[idx] = item
    store(items: items)
}

private func fileURL() -> URL {
    let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    return dir.appendingPathComponent("list")
}
