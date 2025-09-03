import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    var alertController: UIAlertController? {
        guard let alert = UIApplication.topViewController() as? UIAlertController else { return nil }
        return alert
    }
    
    private static let insetBackgroundViewTag = 98721
    
    func paintSafeAreaBottomInset(withColor color: UIColor) {
        guard #available(iOS 11.0, *) else {
            return
        }
        if let insetView = view.viewWithTag(UIViewController.insetBackgroundViewTag) {
            insetView.backgroundColor = color
            return
        }
        
        let insetView = UIView(frame: .zero)
        insetView.tag = UIViewController.insetBackgroundViewTag
        insetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(insetView)
        view.sendSubviewToBack(insetView)
        
        insetView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        insetView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        insetView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        insetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        insetView.backgroundColor = color
    }
}
