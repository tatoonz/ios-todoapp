//
//  AddNewItemViewController.swift
//  TodoApp
//
//  Created by Peerapat Naksumphan on 24/7/2562 BE.
//  Copyright © 2562 Peerapat Naksumphan. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewController(controller: ItemDetailViewController, didAdd item: TodoItem)
    func itemDetailViewController(controller: ItemDetailViewController, didEdit item: TodoItem)
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
}

class ItemDetailViewController: UIViewController {
    weak var delegate: ItemDetailViewControllerDelegate?
    
    var todoItem: TodoItem?

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var isDoneSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let todoItem = todoItem {
            title = "Edit item"
            
            titleTextField.text = todoItem.title
            isDoneSwitch.isOn = todoItem.isDone
        } else {
            title = "Add new item"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        titleTextField.becomeFirstResponder()
    }
    
    @IBAction func doneButtonDidTap(_ sender: UIBarButtonItem) {
        guard let title = titleTextField.text, !title.isEmpty else {
            return
        }
        
        if let todoItem = todoItem {
            todoItem.title = title
            todoItem.isDone = isDoneSwitch.isOn
            delegate?.itemDetailViewController(controller: self, didEdit: todoItem)
        } else {
            let todoItem = TodoItem(title: title, isDone: isDoneSwitch.isOn)
            delegate?.itemDetailViewController(controller: self, didAdd: todoItem)
        }
    }
    
    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        delegate?.itemDetailViewControllerDidCancel(controller: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
