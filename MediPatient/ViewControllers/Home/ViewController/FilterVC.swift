//
//  FilterVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 17/09/25.
//

import UIKit

struct FilterItem {
    let title: String
    var isSelected: Bool
}

class FilterVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    private var isAllSelected: Bool = false
    
    // MARK: - Data
    private var filters: [FilterItem] = [
        FilterItem(title: "Timeline", isSelected: false),
        FilterItem(title: "Insurances", isSelected: false),
        FilterItem(title: "Pharmacies", isSelected: false),
        FilterItem(title: "Problems", isSelected: false),
        FilterItem(title: "Medications", isSelected: false),
        FilterItem(title: "Appointments", isSelected: false),
        FilterItem(title: "Patient Forms", isSelected: false),
        FilterItem(title: "Visit Summary", isSelected: false),
        FilterItem(title: "Invoices", isSelected: false),
        FilterItem(title: "Lab Results", isSelected: false),
        FilterItem(title: "Radiology Results", isSelected: false),
        FilterItem(title: "Procedures", isSelected: false),
        FilterItem(title: "Allergies", isSelected: false),
        FilterItem(title: "Immunizations", isSelected: false),
        FilterItem(title: "Diets", isSelected: false),
        FilterItem(title: "Documents", isSelected: false)
    ]

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        
        // Register your custom cell (FilterCell.xib)
        tableView.register(UINib(nibName: "FilterCell", bundle: nil),
                           forCellReuseIdentifier: FilterCell.identifier)
        
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Actions
    @IBAction func btnCancelTapped(_ sender: UIButton) {
        Redirect.pop(from: self)
    }
    
    @IBAction func btnApplyTapped(_ sender: UIButton) {
        let selected = filters.filter { $0.isSelected }
        print("✅ Selected Filters: \(selected.map { $0.title })")
        dismiss(animated: true, completion: nil)
    }
       func toggleSelectAll() {
           isAllSelected.toggle()
           filters = filters.map { FilterItem(title: $0.title, isSelected: isAllSelected) }
           tableView.reloadData()
       }
}

// MARK: - UITableView Delegate & DataSource
extension FilterVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count + 1 // +1 for select/unselect all
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FilterCell.identifier,
            for: indexPath
        ) as? FilterCell else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            // "Select / Unselect All" row
            let title = isAllSelected ? "Unselect all" : "Select all"
            cell.configure(with: FilterItem(title: title, isSelected: isAllSelected) ,isFirstRow: true)
            
            cell.onToggle = { [weak self] in
                self?.toggleSelectAll()
            }
            
        } else {
            // Normal filter rows
            let item = filters[indexPath.row - 1]
            cell.configure(with: item ,isFirstRow: false)
            
            cell.onToggle = { [weak self] in
                guard let self = self else { return }
                self.filters[indexPath.row - 1].isSelected.toggle()
                
                // Update select all state dynamically
                self.isAllSelected = self.filters.allSatisfy { $0.isSelected }
                self.tableView.reloadRows(at: [indexPath, IndexPath(row: 0, section: 0)], with: .none)
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 60 : 50 // first cell +10
    }

}
