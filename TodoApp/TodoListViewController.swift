//
//  ViewController.swift
//  TodoApp
//
//  Created by Peerapat Naksumphan on 13/4/2562 BE.
//  Copyright © 2562 Peerapat Naksumphan. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITableViewDragDelegate, UITableViewDropDelegate, ItemDetailViewControllerDelegate, TodoItemTableViewCellDelegate {
    
    var todo = Todo()
    @IBOutlet weak var tableView: UITableView?
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.totalItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath) as! TodoItemTableViewCell
        let item = todo.item(at: indexPath.row)
        
        cell.configure(item: item, delegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        todo.move(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "openEditItemSegue", sender: todo.item(at: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todo.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            saveTodo()
        }
    }
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
    }
    
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return session.localDragSession != nil
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    // MARK: - Initial Page
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.dragDelegate = self
        tableView?.dragInteractionEnabled = true
        
        tableView?.dropDelegate = self
        
        loadTodo()
    }
    
    // MARK: - ItemDetailViewControllerDelegate
    func itemDetailViewController(controller: ItemDetailViewController, didAdd item: TodoItem) {
        todo.add(item: item)
        
        if let index = todo.index(of: item) {
            tableView?.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            saveTodo()
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didEdit item: TodoItem) {
        if let index = todo.index(of: item) {
            tableView?.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            saveTodo()
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        if controller.isInEditMode {
            navigationController?.popViewController(animated: true)
        } else {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    // MARK: - TodoItemTableViewCellDelegate
    func todoItemTableViewCellDidTapCheckboxButton(cell: TodoItemTableViewCell) {
        if let indexPath = tableView?.indexPath(for: cell) {
            todo.item(at: indexPath.row).isDone.toggle()
            saveTodo()
            tableView?.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "openAddItemSegue":
            if let nav = segue.destination as? UINavigationController,
                let controller = nav.topViewController as? ItemDetailViewController {
                controller.delegate = self
            }
        case "openEditItemSegue":
            if let controller = segue.destination as? ItemDetailViewController {
                controller.delegate = self
                controller.todoItem = sender as? TodoItem
            }
        default: break
        }
    }
    
    // MARK: Save/Load todos
    func saveTodo() {
        do {
            let destinationURL = try makeTodoFileURL(fileManager: FileManager.default)
            
            let encoder = PropertyListEncoder()
            encoder.outputFormat = .xml
            
            let data = try encoder.encode(todo)
            try data.write(to: destinationURL)
        } catch {
            print("cannot save todo to file, Error: \(error)")
        }
    }
    
    func loadTodo() {
        do {
            let fileManager = FileManager.default
            let destinationURL = try makeTodoFileURL(fileManager: fileManager)
            
            if fileManager.fileExists(atPath: destinationURL.path) {
                let data = try Data(contentsOf: destinationURL)
                let decoder = PropertyListDecoder()
                todo = try decoder.decode(Todo.self, from: data)
                tableView?.reloadData()
            }
        } catch {
            print("cannot load todo from file, Error: \(error)")
        }
    }
    
    func makeTodoFileURL(fileManager: FileManager) throws -> URL {
        var destinationURL = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        destinationURL.appendPathComponent("todo")
        destinationURL.appendPathExtension("plist")
        
        return destinationURL
    }
}
