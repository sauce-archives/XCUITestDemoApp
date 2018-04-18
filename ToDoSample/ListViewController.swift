//
//  ListViewController.swift
//  ToDoSample
//
//  Created by David on 17.04.18.
//  Copyright © 2018 Saucelabs. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var items: [ListItem] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleView(image: #imageLiteral(resourceName: "sauce_logo_large"))
        
        navigationController?.navigationBar.tintColor = UIColor.sauceRed
        items = loadItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "detail" else {
            return
        }
        
        if let vc = segue.destination as? DetailViewController {
            vc.item = sender as? ListItem
        }
    }
    
    @IBAction func addPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Create Item", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { (action) in
            guard let titleTextField = alert.textFields?[0] else {
                return
            }
            
            guard let title = titleTextField.text, title.count > 0 else {
                return
            }
            
            let row = self.items.count
            let item = ListItem(title: title)
            self.items.append(item)
            store(items: self.items)
            
            self.tableView.insertRows(at: [IndexPath(row: row, section: 0)], with: .bottom)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func editPressed(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        sender.title = sender.title == "Edit" ? "Done" : "Edit"
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemRow", for: indexPath) as! ListItemTableViewCell
        
        let item = items[indexPath.row]
        cell.titleLabel.attributedText = nil
        cell.showsReorderControl = true
        cell.doneImageView.image = nil
        
        if item.done {
            let attributes: [NSAttributedStringKey: Any] = [
                .font: cell.titleLabel.font,
                .strikethroughStyle: 1
            ]
            let title = NSAttributedString(string: item.title, attributes: attributes)
            cell.titleLabel.attributedText = title
            cell.titleLabel.accessibilityTraits |= UIAccessibilityTraitSelected
            cell.doneImageView.image = #imageLiteral(resourceName: "saucebot_lederhosen")
            
        } else {
            cell.titleLabel.text = item.title
            if cell.titleLabel.accessibilityTraits & UIAccessibilityTraitSelected > 0 {
                cell.titleLabel.accessibilityTraits ^= UIAccessibilityTraitSelected
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = items.remove(at: sourceIndexPath.row)
        items.insert(item, at: destinationIndexPath.row)
        store(items: items)
    }
    
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            store(items: self.items)
        }
        
        let moveToTop = UITableViewRowAction(style: .normal, title: "Move to top") { (action, indexPath) in
            let item = self.items.remove(at: indexPath.row)
            self.items.insert(item, at: 0)
            
            let rows = (0...indexPath.row).map({ (row) -> IndexPath in
                return IndexPath(row: row, section: 0)
            })
            
            self.tableView.reloadRows(at: rows, with: .automatic)
        }
        
        return [deleteAction, moveToTop]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detail", sender: items[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
