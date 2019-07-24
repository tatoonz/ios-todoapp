//
//  AddNewItemViewController.swift
//  TodoApp
//
//  Created by Peerapat Naksumphan on 24/7/2562 BE.
//  Copyright © 2562 Peerapat Naksumphan. All rights reserved.
//

import UIKit

protocol AddNewItemViewControllerDelegate: class {
    func addNewItemViewController(controller: AddNewItemViewController, didAdd item: TodoItem)
    func addNewItemViewControllerDidCancel(controller: AddNewItemViewController)
}

class AddNewItemViewController: UIViewController {
    weak var delegate: AddNewItemViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonDidTap(_ sender: UIBarButtonItem) {
        delegate?.addNewItemViewController(controller: self, didAdd: TodoItem(title: "Test"))
    }
    
    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        delegate?.addNewItemViewControllerDidCancel(controller: self)
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
