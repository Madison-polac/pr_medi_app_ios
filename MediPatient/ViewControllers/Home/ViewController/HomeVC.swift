//
//  HomeVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 10/09/25.
//


import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tblHeight: NSLayoutConstraint!
    @IBOutlet weak var menuTableView: UITableView!
    
    @IBOutlet weak var blackSideMenuView: UIView!
    // MARK: - Data
    private var items: [CardItem] = []
    private var sideMenuData: SideMenuData = SideMenuData.getMenuData()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainTable()
        setupSideMenuTable()
        loadDummyData()
        setupSideMenu()
        
        tableView.reloadData()
        updateTableHeight()
        navView.dropShadow(color: UIColor(hex: "#000000")!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableHeight()
        
        // Ensure side menu is hidden initially
        if sideMenuView.frame.origin.x == 0 {
            setupSideMenu()
        }
    }
    
    
    @IBAction func btnFilterTapped(_ sender: UIButton) {
        Redirect.to("FilterVC", from: self)
    }
}

// MARK: - Main Table Setup
private extension HomeVC {
    
    func setupMainTable() {
        let nib = UINib(nibName: "CommonCardTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CommonCardTableViewCell.identifier)
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 98
    }
    
    func updateTableHeight() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tblHeight.constant = self.tableView.contentSize.height
            self.view.layoutIfNeeded()
        }
    }
    
    func loadDummyData() {
        items = [
            CardItem(type: .common, iconName: "leaf.fill", title: "Allergies", subtitle: "1. Aspirin\n2. Milk", description:nil, statusText: nil, showJoinButton: false),
            CardItem(type: .common, iconName: "heart.text.square.fill", title: "Problems", subtitle: "Abnormal ECG", description: "Aug 14, 2024",  statusText: nil, showJoinButton: false),
            CardItem(type: .common, iconName: "person.fill", title: "Primary Care Provider", subtitle: "Carter Ruiz",description: "carter.ruiz@gmail.com", statusText: nil, showJoinButton: false),
            CardItem(type: .common, iconName: "shield.fill", title: "Insurance", subtitle: "ICICI", description: "Jul 01, 2025 – Aug 30, 2026", statusText: nil, showJoinButton: false),
            CardItem(type: .videoAppointment, iconName: "video.fill", title: "Video appointment today", subtitle: "12:30 PM", description: "Dr. Lou Nelson, MD", statusText: "Call in progress…", showJoinButton: true),
            CardItem(type: .common, iconName: "leaf.fill", title: "Allergies", subtitle: "1. Aspirin\n2. Milk", description:nil, statusText: nil, showJoinButton: false),
            CardItem(type: .common, iconName: "heart.text.square.fill", title: "Problems", subtitle: "Abnormal ECG", description: "Aug 14, 2024",  statusText: nil, showJoinButton: false),
            CardItem(type: .common, iconName: "person.fill", title: "Primary Care Provider", subtitle: "Carter Ruiz",description: "carter.ruiz@gmail.com", statusText: nil, showJoinButton: false),
            CardItem(type: .common, iconName: "shield.fill", title: "Insurance", subtitle: "ICICI", description: "Jul 01, 2025 – Aug 30, 2026", statusText: nil, showJoinButton: false),
            CardItem(type: .videoAppointment, iconName: "video.fill", title: "Video appointment today", subtitle: "12:30 PM", description: "Dr. Lou Nelson, MD", statusText: "Call in progress…", showJoinButton: true)
        ]
    }
}

// MARK: - Side Menu Setup
private extension HomeVC {
    
    func setupSideMenuTable() {
        menuTableView.dataSource = self
        menuTableView.delegate = self
        
        // Register cells
        menuTableView.register(UINib(nibName: "SideMenuHeaderCell", bundle: nil),
                               forCellReuseIdentifier: SideMenuHeaderCell.identifier)
        menuTableView.register(UINib(nibName: "SideMenuCell", bundle: nil),
                               forCellReuseIdentifier: SideMenuCell.identifier)
        
        menuTableView.separatorStyle = .none
        menuTableView.backgroundColor = .clear
    }
    
    private func setupSideMenu() {
        // Start hidden
        sideMenuView.frame.origin.x = -sideMenuView.frame.width
        
        // Add pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        sideMenuView.addGestureRecognizer(panGesture)
        
        // Add tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        blackSideMenuView.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        toggleSideMenu()
    }


    
    @IBAction func btnMenuTapped(_ sender: UIButton) {
        toggleSideMenu()
    }
    
    func toggleSideMenu() {
        let isHidden = sideMenuView.frame.origin.x < 0
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.sideMenuView.frame.origin.x = isHidden ? 0 : -self.sideMenuView.frame.width
        }
    }
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .changed:
            // Move menu with finger
            let newX = min(0, max(-sideMenuView.frame.width, sideMenuView.frame.origin.x + translation.x))
            sideMenuView.frame.origin.x = newX
            gesture.setTranslation(.zero, in: view)
            
        case .ended, .cancelled:
            // Snap open or closed depending on velocity or position
            let shouldOpen = velocity.x > 0 || sideMenuView.frame.origin.x > -sideMenuView.frame.width / 2
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut) {
                self.sideMenuView.frame.origin.x = shouldOpen ? 0 : -self.sideMenuView.frame.width
            }
            
        default:
            break
        }
    }

}

// MARK: - UITableView Delegate & DataSource
extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return items.count
        } else {
            // 1 for header row + items count
            return 1 + sideMenuData.items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CommonCardTableViewCell.identifier,
                for: indexPath
            ) as? CommonCardTableViewCell else { return UITableViewCell() }
            
            cell.configure(with: items[indexPath.row])
            return cell
            
        } else {
            if indexPath.row == 0 {
                // Profile header
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SideMenuHeaderCell.identifier,
                    for: indexPath
                ) as? SideMenuHeaderCell else { return UITableViewCell() }
                
                let header = sideMenuData.header
                cell.configure(name: header.name,
                               email: header.email,
                               profileImage: header.profileImage)
                return cell
                
            } else {
                // Menu item
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SideMenuCell.identifier,
                    for: indexPath
                ) as? SideMenuCell else { return UITableViewCell() }
                
                let item = sideMenuData.items[indexPath.row - 1]
                cell.configure(iconName: item.iconName, title: item.title)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == menuTableView {
            if indexPath.row == 0 {
                print("Profile tapped")
            } else {
                let item = sideMenuData.items[indexPath.row - 1]
                print("Tapped menu: \(item.title)")
                toggleSideMenu()
            }
           
        }
    }

}
