//
//  TermsVC.swift
//  MediPatient
//
//  Created by Nick Joliya on 22/08/25.
//

import UIKit

class TermsVC: UIViewController {
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var tvDescription: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
    }
    
    // MARK: - Initialization
    private func initialization() {
        btnAccept.applyPrimaryStyle()
        btnReject.applySecondaryStyle()
        tvDescription.font = UIFont.ubuntuMedium(ofSize: 17)
    }
    
}

// MARK: - Actions
extension TermsVC {
    
    @IBAction func btnAcceptTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func btnRejectTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

