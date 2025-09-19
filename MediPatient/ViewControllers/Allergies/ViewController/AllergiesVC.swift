//
//  UrgentCareVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 19/09/25.
//



import UIKit

class AllergiesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var placeholderView: UIView!

    
    private var allergies: [Allergy] = [
           Allergy(name: "Aspirin", observedOn: "Jan 17, 2024", type: "Medication", severity: "Moderate", reaction: "Lorem Ipsum text...", status: .active),
           Allergy(name: "Milk", observedOn: "Jan 17, 2024", type: "Food", severity: "Mild", reaction: nil, status: .active),
           Allergy(name: "Antidepressants", observedOn: "Jan 17, 2024", type: "Medication", severity: "Moderate", reaction: "Lorem Ipsum text...", status: .inactive),
           Allergy(name: "Probuphine", observedOn: "Jan 17, 2024", type: "Medication", severity: "Moderate", reaction: "Lorem Ipsum text...", status: .inactive)
       ]
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: AllergyCell.identifier, bundle: nil),
                               forCellReuseIdentifier: AllergyCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 153
        
        updateTableHeight()
    }
    

    @IBAction func btnBackTapped(_ sender: UIButton) {
        Redirect.pop(from: self)
    }
    
    func updateTableHeight() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tblHeight.constant = self.tableView.contentSize.height
            self.view.layoutIfNeeded()
        }
    }
    
}

extension AllergiesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allergies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AllergyCell.identifier, for: indexPath) as! AllergyCell
               cell.configure(with: allergies[indexPath.row])
               return cell
    }
    
    // MARK: - Custom swipe actions
    // MARK: - Swipe actions with white icon + text
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        
        // EDIT action (green, white icon + text)
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] _, _, completion in
            guard let self = self else { completion(false); return }
            // handle edit
            print("Edit tapped at \(indexPath.row)")
            completion(true)
        }
        editAction.backgroundColor = UIColor.DBF_6_AF
        
        if let pencil = UIImage(named: "icEdit1")?
            .withTintColor(.black, renderingMode: .alwaysOriginal) {
            editAction.image = pencil
        }
        
        // DELETE action (pink, white icon + text)
        // Use .normal so we can control color (avoid automatic red)
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { [weak self] _, _, completion in
            guard let self = self else { completion(false); return }
            self.allergies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.updateTableHeight()
            completion(true)
        }
        deleteAction.backgroundColor = UIColor.F_4_D_8_DD
        
        if let trash = UIImage(named: "icTrash")?
            .withTintColor(.black, renderingMode: .alwaysOriginal) {
            deleteAction.image = trash
        }
        
        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }

}

