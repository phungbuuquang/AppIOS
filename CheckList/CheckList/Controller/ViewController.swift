//
//  ViewController.swift
//  CheckList
//
//  Created by Phung buu quang on 12/8/17.
//  Copyright © 2017 Phung buu quang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var arrayTodo = [ToDo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        arrayTodo = []
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    @IBAction func moveToAddVC(_ sender: UIBarButtonItem) {
        print("ahihi")
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let addNewVC = sb.instantiateViewController(withIdentifier: "addNewVC") as! AddNewViewController
        addNewVC.delegate = self
        self.navigationController?.pushViewController(addNewVC, animated: true)
    }
    

}
extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTodo.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoTableViewCell
        cell.nameTodo.text = arrayTodo[indexPath.row].name
        if arrayTodo[indexPath.row].isComplete{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var todo = arrayTodo[indexPath.row]
        if todo.isComplete{
            todo.isComplete = false
        }
        else{
            todo.isComplete = true
        }
        arrayTodo[indexPath.row] = todo
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}
extension ViewController: AddNewToDoDelegate{
    func addNewToDo(todo: ToDo) {
        arrayTodo.append(todo)
        tableView.reloadData()
    }
    
    
}

