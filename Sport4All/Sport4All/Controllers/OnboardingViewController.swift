//
//  OnboardingViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 20/2/22.
//

import UIKit

class OnboardingViewController: UIViewController {

	// Variables
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
	
	// Outlets
	@IBOutlet weak var skipButton: UIButton!
	@IBOutlet weak var onboardingCollectionView: UICollectionView!
	@IBOutlet weak var pageControl: UIPageControl!
	@IBOutlet weak var nextButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		slides = [
			OnboardingSlide(
				title: "Screen 1",
				description: "En el apartado clubes, podrás encontrar información sobre los clubes en los que podrás reservar espacios deportivos.",
				image: UIImage(named: "WhiteLogo")!),
			OnboardingSlide(
				title: "Screen 2",
				description: "En el apartado partidos podrás jugar con otros usuarios que necesiten compañeros en sus partidos.",
				image: UIImage(named: "WhiteLogo")!),
			OnboardingSlide(
				title: "Screen 3",
				description: "Acceda fácilmente a los establecimientos identificándose con el código Qr que se le facilitará al realizar la reserva.",
				image: UIImage(named: "WhiteLogo")!),
			OnboardingSlide(
				title: "Screen 4",
				description: "Podrá registrarse en los eventos que los clubes realizan, como torneos, partidos amistosos, webinars y muchas más actividades.",
				image: UIImage(named: "WhiteLogo")!),
			OnboardingSlide(
				title: "Screen 5",
				description: "Controle los eventos personalizados que su club le proporcione.",
				image: UIImage(named: "WhiteLogo")!),
			OnboardingSlide(
				title: "Screen 6",
				description: "Registresé en nuesta aplicación y disfrute de la diversión de hacer deporte.",
				image: UIImage(named: "WhiteLogo")!)
		]
		
		
		// Collection View
		onboardingCollectionView.dataSource = self
		onboardingCollectionView.delegate = self
		
		// Page Control
		pageControl.numberOfPages = slides.count
    }
	
	
	// MARK: Action Functions
	@IBAction func skipTutorialButtonAction(_ sender: UIButton) {
		UserDefaultsProvider.setUserDefaults(key: .isNewUser, value: true)
		navigateToAuth()
	}
	
	@IBAction func nextButtonAction(_ sender: UIButton) {
		if currentPage == slides.count - 1 {
			UserDefaultsProvider.setUserDefaults(key: .isNewUser, value: true)
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
