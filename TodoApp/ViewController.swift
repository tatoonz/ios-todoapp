//
//  ViewController.swift
//  TodoApp
//
//  Created by Peerapat Naksumphan on 13/4/2562 BE.
//  Copyright © 2562 Peerapat Naksumphan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddNewItemViewControllerDelegate {
    var todo = Todo()
    
    @IBOutlet weak var tableView: UITableView?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.totalItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)
        let item = todo.item(at: indexPath.row)
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isDone ? .checkmark : .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        todo.add(item: TodoItem(title: "Download XCode", isDone: true))
        todo.add(item: TodoItem(title: "Buy milk"))
        todo.add(item: TodoItem(title: "Learning Swift"))
    }

    func addNewItemViewController(controller: AddNewItemViewController, didAdd item: TodoItem) {
        todo.add(item: item)
        
        if let index = todo.index(of: item) {
            tableView?.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addNewItemViewControllerDidCancel(controller: AddNewItemViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openAddItemSegue" {
            if let nav = segue.destination as? UINavigationController,
                let controller = nav.topViewController as? AddNewItemViewController {
                controller.delegate = self
            }
        }
    }
}
