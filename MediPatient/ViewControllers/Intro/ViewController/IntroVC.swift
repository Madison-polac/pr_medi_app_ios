//
//  IntroViewController.swift
//  MediPatient
//
//  Created by Nick Joliya on 01/09/25.
//


import UIKit

class IntroVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var progressButton: ProgressButton! // custom button
    
    private var slides: [IntroSlide] = []
    private var currentPage = 0
    private let totalPages = 3

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slides = [
            IntroSlide(title: "Get Instant Consult From Your Preferred Doctor",
                       description: "Now you can speak to your preferred doctor within 1 minute through chat/voice call/ video call",
                       image: "banner"),
            IntroSlide(title: "Find Trustworthy Health Information",
                       description: "You will get the most accurate information about any diseases from top-class doctors ",
                       image: "banner"),
            IntroSlide(title: "Upgrade to Healthcare Plan",
                       description: "Get free consultation and 24/7 telehealth access",
                       image: "banner")
        ]
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // ✅ First slice should be filled
        progressButton.totalSteps = totalPages
        //progressButton.currentStep = 1
        updateProgressButton()
    }

    
    func updateProgressButton() {
        if currentPage == totalPages - 1 {
            progressButton.setTitle("Go", for: .normal)
            progressButton.setImage(.none, for: .normal)
            skipButton.isHidden = true
        } else {
            progressButton.setTitle("", for: .normal)
            progressButton.setImage(.icNext, for: .normal)
            skipButton.isHidden = false
        }
        
        progressButton.setStep(currentPage + 1, animated: true)
    }




    
    @IBAction func skipTapped(_ sender: UIButton) {
        goToMainScreen()
    }
    
    @IBAction func progressButtonTapped(_ sender: UIButton) {
        if currentPage == totalPages - 1 {
            // Last page → Navigate to Home/Login
           goToMainScreen()
            // e.g., performSegue(withIdentifier: "showHome", sender: nil)
        }
        else {
            // Move to next page
            let nextIndex = currentPage + 1
            let indexPath = IndexPath(item: nextIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            currentPage = nextIndex
            updateProgressButton()
        }
    }

    
    private func goToMainScreen() {
        Redirect.to("LoginVC", from: self)
    }
}

extension IntroVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
   

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroCell", for: indexPath) as! IntroCell
        let slide = slides[indexPath.item]
        cell.titleLabel.text = slide.title
        cell.descLabel.text = slide.description
        cell.imageView.image = UIImage(named: slide.image)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        currentPage = page
        updateProgressButton()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}
