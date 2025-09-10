//
//  HomeVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 10/09/25.
//


import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var lblWelcome: UILabel!
    @IBOutlet weak var btnLogout: UIButton!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - UI Setup
extension HomeVC {
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        lblWelcome.text = "🎉 Welcome to Home Screen"
        lblWelcome.textAlignment = .center
        lblWelcome.font = UIFont.boldSystemFont(ofSize: 20)
        lblWelcome.textColor = .label
        
        btnLogout.setTitle("Logout", for: .normal)
        btnLogout.backgroundColor = UIColor.systemRed
        btnLogout.setTitleColor(.white, for: .normal)
        btnLogout.layer.cornerRadius = 8
    }
}

// MARK: - Actions
extension HomeVC {
    @IBAction func btnLogoutTapped(_ sender: UIButton) {
        // Dummy logout → go back to LoginVC
        Redirect.to("LoginVC", from: self)
    }
}
