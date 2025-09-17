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
    
    // Keep stable gradient color per item
    private var gradientColor: UIColor?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bgView.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        gradientColor = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bgView.layoutIfNeeded()
        
        // Apply shadow + gradient
        bgView.applyShadow()
        if let color = gradientColor {
            bgView.applyTopRightGradient(primaryColor: color, cornerRadius: 12)
        }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        selectionStyle = .none
        bgView.layer.cornerRadius = 12
        bgView.layer.masksToBounds = false
        
        // Fonts
        lblTitle.font = UIFont.ubuntuMedium(ofSize: 17)
        lblSubtitle.font = UIFont.ubuntuRegular(ofSize: 14)
        lblDesc.font = UIFont.ubuntuRegular(ofSize: 10)
        lblStatus.font = UIFont.ubuntuMedium(ofSize: 12)
        
        // Button
        btnJoin.layer.cornerRadius = 6
        btnJoin.titleLabel?.font = UIFont.ubuntuMedium(ofSize: 12)
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
        
        // Assign a stable random color once per configure
        gradientColor = UIColor.randomLightColor()
    }
}

