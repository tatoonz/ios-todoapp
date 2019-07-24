//
//  Todo.swift
//  TodoApp
//
//  Created by Peerapat Naksumphan on 20/7/2562 BE.
//  Copyright © 2562 Peerapat Naksumphan. All rights reserved.
//

import Foundation

class Todo {
    private var items = [TodoItem]()
    
    var totalItems: Int {
        return items.count
    }
    
    func item(at index: Int) -> TodoItem {
        return items[index]
    }
    
    func add(item: TodoItem) {
        items.insert(item, at: 0)
    }
    
    func remove(at index: Int) {
        items.remove(at: index)
    }
    
    func index(of item: TodoItem) -> Int? {
        return items.firstIndex(where: { (todoItem) -> Bool in
            return todoItem === item
        })
    }
    
    func move(from sourceIndex: Int, to destinationIndex: Int) {
        let item = items.remove(at: sourceIndex)
        items.insert(item, at: destinationIndex)
    }
}
