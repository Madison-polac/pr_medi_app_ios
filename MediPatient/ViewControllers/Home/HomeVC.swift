//
//  HomeVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 10/09/25.
//


import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Data
    private var items: [CardItem] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Health Records"
        
        setupTableView()
        loadDummyData()
        
        // ✅ Reload after data is ready
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
        
    private func setupTableView() {
        let nib = UINib(nibName: "CommonCardTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CommonCardTableViewCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 98
    }

    
    // MARK: - Dummy Data
    private func loadDummyData() {
        items = [
            CardItem(type: .common, iconName: "leaf.fill", title: "Allergies", subtitle: "1. Aspirin\n2. Milk", description:nil, statusText: nil, showJoinButton: false),
            CardItem(type: .common, iconName: "heart.text.square.fill", title: "Problems", subtitle: "Abnormal ECG", description: "Aug 14, 2024",  statusText: nil, showJoinButton: false),
            CardItem(type: .common, iconName: "person.fill", title: "Primary Care Provider", subtitle: "Carter Ruiz",description: "carter.ruiz@gmail.com", statusText: nil, showJoinButton: false),
            CardItem(type: .common, iconName: "shield.fill", title: "Insurance", subtitle: "ICICI", description: "Jul 01, 2025 – Aug 30, 2026", statusText: nil, showJoinButton: false),
            CardItem(type: .videoAppointment, iconName: "video.fill", title: "Video appointment today", subtitle: "12:30 PM", description: "Dr. Lou Nelson, MD", statusText: "Call in progress…", showJoinButton: true),
            CardItem(type: .common, iconName: "leaf.fill", title: "Allergies", subtitle: "1. Aspirin\n2. Milk",  description: nil, statusText: nil, showJoinButton: false),
            CardItem(type: .common, iconName: "heart.text.square.fill", title: "Problems", subtitle: "Abnormal ECG", description: "Aug 14, 2024", statusText: nil, showJoinButton: false),
            CardItem(type: .common, iconName: "person.fill", title: "Primary Care Provider", subtitle: "Carter Ruiz",  description: "carter.ruiz@gmail.com", statusText: nil, showJoinButton: false),
            CardItem(type: .common, iconName: "shield.fill", title: "Insurance", subtitle: "ICICI", description: "Jul 01, 2025 – Aug 30, 2026", statusText: nil, showJoinButton: false),
            CardItem(type: .videoAppointment, iconName: "video.fill", title: "Video appointment today", subtitle: "12:30 PM", description: "Dr. Lou Nelson, MD", statusText: "Call in progress…", showJoinButton: true)
        ]
    }
}
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommonCardTableViewCell.identifier, for: indexPath) as? CommonCardTableViewCell else {
            return UITableViewCell()
        }
        let item = items[indexPath.row] // use section here!
        cell.configure(with: item)
        return cell
    }

    
    // MARK: - Swipe Actions
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, completion in
            print("Edit tapped at \(indexPath.section)") // note: section instead of row
            completion(true)
        }
        editAction.backgroundColor = .systemBlue

        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }


        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }

}

