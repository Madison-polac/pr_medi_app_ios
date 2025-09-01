//
//  ProgressButton.swift
//  MediPatient
//
//  Created by Nick Joliya on 01/09/25.
//

import UIKit

@IBDesignable
class ProgressButton: UIButton {
    
    private let separatorLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    
    @IBInspectable var totalSteps: Int = 3
    private var currentStep: Int = 1
    
    @IBInspectable var progressColor: UIColor = .theme {
        didSet { progressLayer.strokeColor = progressColor.cgColor }
    }
    
    @IBInspectable var trackColor: UIColor = UIColor.themeSecondary {
        didSet { trackLayer.strokeColor = trackColor.cgColor }
    }
    
    @IBInspectable var separatorColor: UIColor = .white {
        didSet { separatorLayer.strokeColor = separatorColor.cgColor }
    }
    
    @IBInspectable var lineWidth: CGFloat = 4 {
        didSet {
            trackLayer.lineWidth = lineWidth
            progressLayer.lineWidth = lineWidth
        }
    }
    
    @IBInspectable var separatorWidth: CGFloat = 4 {
        didSet {
            separatorLayer.lineWidth = separatorWidth
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePaths()
        layer.cornerRadius = bounds.size.width / 2
        clipsToBounds = true
    }
    
    private func setupLayers() {
        // Separator ring
        separatorLayer.fillColor = UIColor.clear.cgColor
        separatorLayer.strokeColor = separatorColor.cgColor
        separatorLayer.lineWidth = separatorWidth
        layer.addSublayer(separatorLayer)
        
        // Track layer
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = lineWidth
        layer.addSublayer(trackLayer)
        
        // Progress layer
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = lineWidth
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
        
        // Center fill
        backgroundColor = UIColor.theme
        setTitleColor(.black, for: .normal)
    }
    
    private func updatePaths() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let outerRadius = (min(bounds.width, bounds.height) - lineWidth) / 2
        let separatorRadius = outerRadius - (lineWidth / 2) - (separatorWidth / 2)
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 2 * CGFloat.pi
        
        // Outer track + progress
        let outerPath = UIBezierPath(arcCenter: center, radius: outerRadius,
                                     startAngle: startAngle, endAngle: endAngle, clockwise: true)
        trackLayer.path = outerPath.cgPath
        progressLayer.path = outerPath.cgPath
        
        // Inner separator ring
        let separatorPath = UIBezierPath(arcCenter: center, radius: separatorRadius,
                                         startAngle: startAngle, endAngle: endAngle, clockwise: true)
        separatorLayer.path = separatorPath.cgPath
    }
    
    func setStep(_ step: Int, animated: Bool = true) {
        currentStep = max(1, min(step, totalSteps))
        let progress = CGFloat(currentStep) / CGFloat(totalSteps)
        
        if animated {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = progressLayer.presentation()?.strokeEnd ?? 0
            animation.toValue = progress
            animation.duration = 0.3
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            progressLayer.add(animation, forKey: "progressAnim")
        } else {
            progressLayer.strokeEnd = progress
        }
    }
}
