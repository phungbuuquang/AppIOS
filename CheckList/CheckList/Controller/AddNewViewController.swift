//
//  AddNewViewController.swift
//  CheckList
//
//  Created by Phung buu quang on 12/8/17.
//  Copyright © 2017 Phung buu quang. All rights reserved.
//

import UIKit

protocol AddNewToDoDelegate: class {
    func addNewToDo(todo: ToDo)
}

class AddNewViewController: UIViewController {

    @IBOutlet weak var todoTextField: UITextField!
    weak var delegate: AddNewToDoDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addNewToDoPress(_ sender: Any) {
        let nameToDo = todoTextField.text
        if nameToDo == ""{
            
        }else{
            let name = nameToDo?.uppercased()
            delegate?.addNewToDo(todo: ToDo(name: name!, isComplete: false))
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    

}
