//
//  TodoItemTableViewCell.swift
//  TodoApp
//
//  Created by Peerapat Naksumphan on 24/7/2562 BE.
//  Copyright © 2562 Peerapat Naksumphan. All rights reserved.
//

import UIKit

class TodoItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkboxButton: UIButton?
    @IBOutlet weak var titleLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(item: TodoItem) {
        titleLabel?.text = item.title
        checkboxButton?.setImage(UIImage(named: item.isDone ? "check" : "uncheck"), for: .normal)
    }

}
