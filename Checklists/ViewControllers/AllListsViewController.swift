//
//  AddItemTableViewController.swift
//  Checklists
//
//  Created by Sreyash Srivastava on 16/03/25.
//

import UIKit

class AllListsViewController: UITableViewController {

    let cellIdentifier = "ChecklistCell"
    
    var dataModel: DataModel!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
//        tableView
//            .register(
//                UITableViewCell.self,
//                forCellReuseIdentifier: cellIdentifier
//            )
        
        print("Documents directory is: \(dataModel.documentsDirectory())")
        print("DataFile path is : \(dataModel.dataFilePath())")
    }
    
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

      navigationController?.delegate = self

        let index = dataModel.indexOfSelectedChecklist
        if index >= 0 && index < dataModel.lists.count {
        let checklist = dataModel.lists[index]
        performSegue(
          withIdentifier: "ShowChecklist",
          sender: checklist)
      }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell!
        if let tmp = tableView.dequeueReusableCell(
          withIdentifier: cellIdentifier) {
          cell = tmp
        } else {
          cell = UITableViewCell(
            style: .subtitle,
            reuseIdentifier: cellIdentifier)
        }
        
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel?.text = checklist.name
        cell.accessoryType = .detailDisclosureButton
        cell.detailTextLabel!.text = "\(checklist.countUncheckedItems()) Remaining"
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        dataModel.indexOfSelectedChecklist = indexPath.row
        let list = dataModel.lists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: list)
    }
    
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
            dataModel.lists.remove(at: indexPath.row)

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

        let checklist = dataModel.lists[indexPath.row]
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
        let newRowIndex = dataModel.lists.count
        dataModel.lists.append(checklist)

        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)

        navigationController?.popViewController(animated: true)
    }

    func listDetailViewController(
        _ controller: ListDetailViewController,
        didFinishEditing checklist: Checklist
    ) {
        if let index = dataModel.lists.firstIndex(of: checklist) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                cell.textLabel!.text = checklist.name
            }
        }
        navigationController?.popViewController(animated: true)
    }    
}

extension AllListsViewController: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self{
            dataModel.indexOfSelectedChecklist = -1
        }
    }
    
}
