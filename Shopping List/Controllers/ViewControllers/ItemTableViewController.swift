//
//  TodoTableViewController.swift
//  Shopping List
//
//  Created by Sebastian Banks on 3/25/22.
//

import UIKit

class ItemTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ItemController.shared.loadFromPersistantStore()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: "Add Item",
            message: "",
            preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "Add Item Here..."
            field.returnKeyType = .done
        }
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil)
        )
        
        alert.addAction(UIAlertAction(
            title: "Add",
            style: .default,
            handler: { _ in
                guard let field = alert.textFields else { return }
                guard let item = field[0].text, !item.isEmpty else { return }
                
                print(item)
                ItemController.shared.addTodoItem(itemName: item)
                self.tableView.reloadData()
            })
        )
        
        present(alert, animated: true)
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ItemController.shared.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as? ItemTableViewCell else {
            return UITableViewCell()
        }
        
        let item = ItemController.shared.items[indexPath.row]
        cell.delegate = self
        cell.updateView(item: item)
        // Configure the cell...

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let itemToDelete = ItemController.shared.items[indexPath.row]
            ItemController.shared.deleteTodo(item: itemToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }


}

extension ItemTableViewController: ItemCellDelegate {
    func toggleIsDone(for cell: ItemTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let item = ItemController.shared.items[indexPath.row]
        ItemController.shared.updateTodoIsDone(for: item)
        cell.updateView(item: item)
    }
    
    
}
