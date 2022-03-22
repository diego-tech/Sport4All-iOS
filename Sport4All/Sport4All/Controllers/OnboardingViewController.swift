//
//  OnboardingViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 20/2/22.
//

import UIKit

class OnboardingViewController: UIViewController {

	// MARK: Variables
	var slides: [OnboardingSlide] = []
	var currentPage = 0 {
		didSet {
			pageControl.currentPage = currentPage
			if currentPage == slides.count - 1 {
				nextButton.setTitle("COMENZAR", for: .normal)
			} else {
				nextButton.setTitle("SIGUIENTE", for: .normal)
			}
		}
	}
	
	// MARK: Outlets
	@IBOutlet weak var skipButton: UIButton!
	@IBOutlet weak var onboardingCollectionView: UICollectionView!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var nextButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		slides = [
			OnboardingSlide(
				title: Strings.slide1Title,
				description: Strings.slide1Description,
				image: UIImage(named: "InfoBlue")!),
			OnboardingSlide(
				title: Strings.slide2Title,
				description: Strings.slide2Description,
				image: UIImage(named: "SocialOnboard")!),
			OnboardingSlide(
				title: Strings.slide3Title,
				description: Strings.slide3Description,
				image: UIImage(named: "QRCode")!),
			OnboardingSlide(
				title: Strings.slide4Title,
				description: Strings.slide4Description,
				image: UIImage(named: "Trophy")!),
			OnboardingSlide(
				title: Strings.slide5Title,
				description: Strings.slide5Description,
				image: UIImage(named: "Player")!)
		]
		
		// Collection View
		onboardingCollectionView.dataSource = self
		onboardingCollectionView.delegate = self
		
		// Page Control
		pageControl.numberOfPages = slides.count
    }
	
	
	// MARK: Action Functions
	@IBAction func skipTutorialButtonAction(_ sender: UIButton) {
		UserDefaultsProvider.shared.setUserDefaults(key: .isNewUser, value: true)
		navigateToAuth()
	}
	
	@IBAction func nextButtonAction(_ sender: UIButton) {
		if currentPage == slides.count - 1 {
			UserDefaultsProvider.shared.setUserDefaults(key: .isNewUser, value: true)
			navigateToAuth()
		} else {
			currentPage += 1
			let indexPath = IndexPath(item: currentPage, section: 0)
			onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
		}
	}
	
	// MARK: Functions
	private func navigateToAuth() {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
		vc.modalPresentationStyle = .fullScreen
		vc.modalTransitionStyle = .flipHorizontal
		present(vc, animated: true, completion: nil)
	}
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return slides.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
		cell.setUp(slides[indexPath.row])
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let width = scrollView.frame.width
		currentPage = Int(scrollView.contentOffset.x / width)
	}
}
