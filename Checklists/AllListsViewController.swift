//
//  AddItemTableViewController.swift
//  Checklists
//
//  Created by Sreyash Srivastava on 16/03/25.
//

import UIKit

class AllListsViewController: UITableViewController {

    let cellIdentifier = "ChecklistCell"
    var lists = Array<Checklist>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView
            .register(
                UITableViewCell.self,
                forCellReuseIdentifier: cellIdentifier
            )
        
        // Add placeholder data
        var list = Checklist(name: "Birthdays")
        lists.append(list)

        list = Checklist(name: "Groceries")
        lists.append(list)

        list = Checklist(name: "Cool Apps")
        lists.append(list)

        list = Checklist(name: "To Do")
        lists.append(list)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: cellIdentifier,
            for: indexPath
        )
        let checklist = lists[indexPath.row]
        cell.textLabel?.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let list = lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: list)
    }
    
    override func tableView(
      _ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath) {
          lists.remove(at: indexPath.row)

          let indexPaths = [indexPath]
          tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(
      _ tableView: UITableView,
      accessoryButtonTappedForRowWith indexPath: IndexPath
    ) {
      let controller = storyboard!.instantiateViewController(
        withIdentifier: "ListDetailViewController") as! ListDetailViewController
      controller.delegate = self

      let checklist = lists[indexPath.row]
      controller.checklistToEdit = checklist

      navigationController?.pushViewController(
        controller,
        animated: true)
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist"{
            let controller = segue.destination as! ChecklistViewController
            controller.checklist = sender as? Checklist
        } else if segue.identifier == "AddChecklist"{
            let controller = segue.destination as! ListDetailViewController
            controller.delegate = self
        }
    }
    

}

extension AllListsViewController: ListDetailViewControllerDelegate{

    func listDetailViewControllerDidCancel(
        _ controller: ListDetailViewController
    ) {
        navigationController?.popViewController(animated: true)
    }

    func listDetailViewController(
        _ controller: ListDetailViewController,
        didFinishAdding checklist: Checklist
    ) {
        let newRowIndex = lists.count
        lists.append(checklist)

        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)

        navigationController?.popViewController(animated: true)
    }

    func listDetailViewController(
        _ controller: ListDetailViewController,
        didFinishEditing checklist: Checklist
    ) {
        if let index = lists.firstIndex(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
