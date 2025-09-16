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
    
    @IBOutlet weak var shadowView: UIView!
    // Keep a reference to gradient layer
    private var gradientLayer: CAGradientLayer?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Remove old gradient
        gradientLayer?.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        gradientLayer = nil
        
        // Reset UI
        ivIcon.image = nil
        lblTitle.text = nil
        lblSubtitle.text = nil
        lblDesc.text = nil
        lblStatus.text = nil
        lblStatus.isHidden = true
        btnView.isHidden = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Apply shadow (always update frame)
        addShadow(to: bgView)
        // Add a new gradient with a random light color for this cell
        //addTopRightGradient(to: bgView, color: UIColor.randomLightColor())
        
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        selectionStyle = .none
        
       // bgView.layer.cornerRadius = 12
        //bgView.layer.masksToBounds = false // needed for shadow
        
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
        
       
    }
    
    // MARK: - Gradient
    private func addTopRightGradient(to view: UIView, color: UIColor, cornerRadius: CGFloat = 12) {
        gradientLayer?.removeFromSuperlayer() // remove old gradient
        
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.startPoint = CGPoint(x: 1, y: 0)     // top-right
        gradient.endPoint   = CGPoint(x: 0.7, y: 0.5) // fade
        gradient.colors = [color.cgColor, UIColor.white.cgColor]
        gradient.locations = [0.0, 0.8]
        
        // Corner radius mask
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: view.bounds, cornerRadius: cornerRadius).cgPath
        gradient.mask = maskLayer
        
        view.layer.insertSublayer(gradient, at: 0)
        gradientLayer = gradient
    }
    
    // MARK: - Shadow
    private func addShadow(
        to view: UIView,
        color: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1), // #0000001A
        opacity: Float = 1.0,      // set to 1.0 because alpha is already in color
        radius: CGFloat = 6,        // blur
        offset: CGSize = CGSize(width: 0, height: 4) // x:0, y:4
    ) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = offset
        view.layer.masksToBounds = false
    }

}
