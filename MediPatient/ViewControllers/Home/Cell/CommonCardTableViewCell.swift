//
//  CommonCardTableViewCell.swift
//  MediPatient
//
//  Created by Nick Joliya on 15/09/25.
//


import UIKit

class CommonCardTableViewCell: UITableViewCell {
    static let identifier = "CommonCardTableViewCell"
    
    // MARK: - Outlets
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubtitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var btnJoin: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var btnView: UIView!
    
    // Keep a reference to gradient
    private var gradientLayer: CAGradientLayer?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Update gradient frame instead of recreating
        gradientLayer?.frame = bgView.bounds
        
        addShadow(to: bgView,
                  color: .black,
                  opacity: 0.25,
                  radius: 6,
                  offset: CGSize(width: 0, height: 3))
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        selectionStyle = .none
        bgView.layer.cornerRadius = 12
        bgView.layer.masksToBounds = false // important for shadow
        
        // Fonts
        lblTitle.font = UIFont.ubuntuMedium(ofSize: 17)
        lblSubtitle.font = UIFont.ubuntuRegular(ofSize: 14)
        lblDesc.font = UIFont.ubuntuRegular(ofSize: 10)
        lblStatus.font = UIFont.ubuntuMedium(ofSize: 12)
        
        // Button
        btnJoin.layer.cornerRadius = 6
        btnJoin.titleLabel?.font = UIFont.ubuntuMedium(ofSize: 12)
        
        addTopRightGradient(to: bgView)
    }
    
    // MARK: - Config
    func configure(with item: CardItem) {
        if let iconName = item.iconName {
            ivIcon.image = UIImage(systemName: iconName) ?? UIImage(named: iconName)
        } else {
            ivIcon.image = nil
        }
        
        lblTitle.text = item.title
        lblSubtitle.text = item.subtitle
        lblDesc.text = item.description
        
        if let status = item.statusText {
            lblStatus.text = status
            lblStatus.isHidden = false
        } else {
            lblStatus.isHidden = true
        }
        
        btnView.isHidden = !item.showJoinButton
    }
    
    
    func addTopRightGradient(to view: UIView, cornerRadius: CGFloat = 12) {
        gradientLayer?.removeFromSuperlayer()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        
        // Spread further across card
        gradient.startPoint = CGPoint(x: 1, y: 0)     // top-right
        gradient.endPoint   = CGPoint(x: 0.7, y: 0.5) // fade diagonally toward center/bottom
        
        let color1 = UIColor.randomLightColor().cgColor
        let color2 = UIColor.white.cgColor
        gradient.colors = [color1, color2]
        
        // Make fade smoother & longer
        gradient.locations = [0.0, 0.8]
        
        gradient.cornerRadius = cornerRadius
        view.layer.insertSublayer(gradient, at: 0)
        
        gradientLayer = gradient
    }


    func addShadow(to view: UIView, color: UIColor = .black, opacity: Float = 0.2, radius: CGFloat = 4, offset: CGSize = CGSize(width: 0, height: 2)) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = offset
        view.layer.masksToBounds = false
    }
}
