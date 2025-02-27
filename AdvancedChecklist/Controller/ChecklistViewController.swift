//
//  ViewController.swift
//  AdvancedChecklist
//
//  Created by Sreyash Srivastava on 25/02/25.
//

import UIKit

class ChecklistViewController: UITableViewController {

    var checklistItems:[ChecklistItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setModel()
    }
    
    func setModel(){
        checklistItems = [
            ChecklistItemModel(name: "Buy groceries", isChecked: false),
            ChecklistItemModel(name: "Walk the dog", isChecked: false),
            ChecklistItemModel(name: "Finish iOS project", isChecked: false),
            ChecklistItemModel(name: "Call mom", isChecked: false),
            ChecklistItemModel(name: "Read a book", isChecked: false),
            ChecklistItemModel(name: "Exercise for 30 mins", isChecked: false),
            ChecklistItemModel(name: "Prepare dinner", isChecked: false),
            ChecklistItemModel(name: "Pay bills", isChecked: false),
            ChecklistItemModel(name: "Clean the house", isChecked: false),
            ChecklistItemModel(name: "Plan weekend trip", isChecked: false),
            ChecklistItemModel(name: "Buy groceries", isChecked: false),
            ChecklistItemModel(name: "Walk the dog", isChecked: false),
            ChecklistItemModel(name: "Finish iOS project", isChecked: false),
            ChecklistItemModel(name: "Call mom", isChecked: false),
            ChecklistItemModel(name: "Read a book", isChecked: false),
            ChecklistItemModel(name: "Exercise for 30 mins", isChecked: false),
            ChecklistItemModel(name: "Prepare dinner", isChecked: false),
            ChecklistItemModel(name: "Pay bills", isChecked: false),
            ChecklistItemModel(name: "Clean the house", isChecked: false),
            ChecklistItemModel(name: "Plan weekend trip", isChecked: false),
            ChecklistItemModel(name: "Plan weekend trip", isChecked: false),
            ChecklistItemModel(name: "Buy groceries", isChecked: false),
            ChecklistItemModel(name: "Walk the dog", isChecked: false),
            ChecklistItemModel(name: "Finish iOS project", isChecked: false),
            ChecklistItemModel(name: "Call mom", isChecked: false),
            ChecklistItemModel(name: "Read a book", isChecked: false),
            ChecklistItemModel(name: "Exercise for 30 mins", isChecked: false),
            ChecklistItemModel(name: "Prepare dinner", isChecked: false),
            ChecklistItemModel(name: "Pay bills", isChecked: false),
            ChecklistItemModel(name: "Clean the house", isChecked: false),
            ChecklistItemModel(name: "Plan weekend trip", isChecked: false)
        ]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let cellLable = cell.viewWithTag(1000) as! UILabel?
        
        cellLable?.text = checklistItems[indexPath.row].name
        cell.accessoryType = checklistItems[indexPath.row].isChecked ? .checkmark : .none
        
        
        // TODO: More line to be added
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // FIXME: this row has to be changed
        return checklistItems.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if checklistItems[indexPath.row].isChecked == true{
            checklistItems[indexPath.row].isChecked = false
            cell?.accessoryType = .none
        } else {
            checklistItems[indexPath.row].isChecked = true
            cell?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

