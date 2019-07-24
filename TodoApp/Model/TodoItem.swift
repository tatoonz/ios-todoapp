//
//  TodoItem.swift
//  TodoApp
//
//  Created by Peerapat Naksumphan on 20/7/2562 BE.
//  Copyright © 2562 Peerapat Naksumphan. All rights reserved.
//

import Foundation

class TodoItem: Codable {
    var title: String
    var isDone: Bool
    
    init(title: String, isDone: Bool = false) {
        self.title = title
        self.isDone = isDone
    }
}
