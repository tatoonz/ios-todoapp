//
//  AddNewItemViewController.swift
//  TodoApp
//
//  Created by Peerapat Naksumphan on 24/7/2562 BE.
//  Copyright © 2562 Peerapat Naksumphan. All rights reserved.
//

import UIKit

class AddNewItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonDidTap(_ sender: UIBarButtonItem) {
        print("done")
    }
    
    @IBAction func cancelButtonDidTap(_ sender: UIBarButtonItem) {
        print("cancel")
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
