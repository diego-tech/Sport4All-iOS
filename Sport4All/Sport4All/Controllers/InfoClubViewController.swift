//
//  InfoClubViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 15/2/22.
//

import UIKit
import MapKit
import Contacts
import SPIndicator

class InfoClubViewController: UIViewController {
	
	// MARK: Variables
	var club: Club?
	var location: Location?
	private var isFavourite: Bool = false
	
	// MARK: Outlets
	@IBOutlet weak var headerUIView: UIView!
	@IBOutlet weak var reservBTN: UIButton!
	@IBOutlet weak var clubBannerImageView: LazyImageView!
	@IBOutlet weak var clubTitleLabel: UILabel!
	@IBOutlet weak var clubInfoTextView: UITextView!
	@IBOutlet weak var clubServicesStackView: UIStackView!
	@IBOutlet weak var goWebClubButton: UIButton!
	@IBOutlet weak var phoneClubButton: UIButton!
	@IBOutlet weak var addFavouriteButton: UIButton!
	@IBOutlet weak var locationMapView: MKMapView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		// Map View Delegate
		locationMapView.delegate = self
		
		// Configure Models
		configure()
		
		// Configure Favourite
		setFavouriteButton()
		
		// Configure NavBar
		configureNavbar()
		
		// Inicialización Estilos
		buttonStyles()
		headerUIView.bottomShadow()
	}
	
	// MARK: Action Functions
	@IBAction func addToFavouriteButtonAction(_ sender: UIButton) {
		if isFavourite {
			isFavourite = false
		} else {
			isFavourite = true
		}
		
		callAddFavorRemove()
		setFavouriteButton()
	}
	
	@IBAction func goToWebButtonAction(_ sender: UIButton) {
		guard let web = club?.web else { return }
		if let urlToOpen = URL(string: web) {
			UIApplication.shared.open(urlToOpen, options: [:], completionHandler: nil )
		}
	}
	
	@IBAction func goToCallButtonAction(_ sender: UIButton) {
		
		guard let tlf = club?.tlf else { return }
		if let urlToOpen = URL(string: "tel://\(tlf)") {
			UIApplication.shared.open(urlToOpen, options: [:], completionHandler: nil )
		}
	}
	
	@IBAction func reserveButtonAction(_ sender: UIButton) {
		let vc = UIStoryboard(name: "ReservesScreen", bundle: nil).instantiateViewController(withIdentifier: "ReservesScreen") as! ReservesViewController
		vc.club = club
		navigationController?.pushViewController(vc, animated: true)
	}
	
	// MARK: Functions
	private func configure() {
		guard let club = club else { return debugPrint("Error Club") }
		guard let banner = club.clubBanner else { return debugPrint("Error Banner") }
		guard let bannerUrl = URL(string: Constants.kStorageURL + banner) else { return debugPrint("Error Url Imagen") }
		guard let description = club.description else { return debugPrint("Error Desc") }
		guard let services = club.services else { return debugPrint("Error Servicios") }
		guard let location = club.direction else { return debugPrint("Error Dirección") }
		guard let fav = club.fav else { return debugPrint("Error Fav") }
		
		self.clubTitleLabel.text = club.name
		
		self.clubBannerImageView.loadImage(fromURL: bannerUrl)
		
		self.clubInfoTextView.text = description
		self.clubServicesStackView.setServicesInStackView(services: services, imageSize: CGRect(x: 0, y: 0, width: 50, height: 50))
		print("Location \(location)")
		self.callFindLocation(locationName: location)
		
		if fav {
			isFavourite = true
		} else {
			isFavourite = false
		}
	}
	
	private func callFindLocation(locationName: String) {
		LocationProvider.shared.findLocation(with: locationName) { [weak self] location in
			DispatchQueue.main.async {
				self?.location = location
				self?.configureMapView()
			}
		}
	}
	
	private func callAddFavorRemove() {
		guard let id = club?.id else { return }
		
		if !isFavourite {
			NetworkingProvider.shared.deleteFavouriteClub(clubId: id) { status, msg in
				guard let status = status else { return }
				guard let msg = msg else { return }
				if status != 1 {
					if self.isFavourite {
						self.isFavourite = true
					} else {
						self.isFavourite = false
					}
					let indicator = SPIndicatorView(title: "Ha ocurrido un error", message: msg, preset: .error)
					indicator.present(duration: 2)
				}
			} failure: { error in
				guard let error = error else { return }
				debugPrint("Delete Favourite Club \(error)")
				self.goToAuth()
			}
		} else {
			NetworkingProvider.shared.registerFavClub(clubId: id) { responseData, status, msg in
				guard responseData != nil else { return }
				guard let status = status else { return }
				guard let msg = msg else { return }
				if status != 1 {
					if self.isFavourite {
						self.isFavourite = true
					} else {
						self.isFavourite = false
					}
					let indicator = SPIndicatorView(title: "Ha ocurrido un error", message: msg, preset: .error)
					indicator.present(duration: 2)
				}
			} failure: { error in
				guard let error = error else { return }
				debugPrint("Add Favourite Club \(error)")
				self.goToAuth()
			}
		}
	}
	
	private func goToAuth() {
		let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
		vc.modalPresentationStyle = .fullScreen
		vc.modalTransitionStyle = .coverVertical
		vc.errorType = .decodingError
		present(vc, animated: true, completion: nil)
	}
	
	private func configureMapView() {
		locationMapView.removeAnnotations(locationMapView.annotations)
		guard let coordinates = location?.coordinates else { return }
		guard let locationName = location?.title else { return }
		guard let placeName = club?.name else { return }
		
		let annotation = Annotation(coordinate: coordinates, title: placeName, subtitle: locationName)
		locationMapView.isZoomEnabled = false
		locationMapView.isScrollEnabled = false
		locationMapView.isPitchEnabled = false
		locationMapView.isRotateEnabled = false
		locationMapView.addAnnotation(annotation)
		locationMapView.setRegion(MKCoordinateRegion(
			center: coordinates,
			span: MKCoordinateSpan(
				latitudeDelta: 0.01,
				longitudeDelta: 0.01)
		), animated: true)
	}
	
	private func setFavouriteButton() {
		self.addFavouriteButton.setImage(UIImage(systemName: !isFavourite ? "star" : "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
	}
	
	// MARK: Styles
	private func buttonStyles() {
		// Botón Reservar
		reservBTN?.round()
	}
	
	private func configureNavbar() {
		self.navigationController!.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		
		title = Strings.infoClubTitle
		
		let yourBackImage = UIImage(systemName: "arrowshape.turn.up.backward.fill", withConfiguration:  UIImage.SymbolConfiguration(pointSize: 18))
		let backButtonItem = UIBarButtonItem(image: yourBackImage, style: .plain, target: self, action: #selector(popView(tapGestureRecognizer:)))
		backButtonItem.tintColor = .corporativeColor
		
		self.navigationItem.leftBarButtonItem = backButtonItem
		
		self.navigationItem.setHidesBackButton(true, animated: true)
	}
	
	@objc func popView(tapGestureRecognizer: UITapGestureRecognizer) {
		self.navigationController?.popViewController(animated: true)
	}
}

// MARK: MKMapView Extension
extension InfoClubViewController: MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "something")
		let mapsButton = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 48, height: 48)))
		mapsButton.setBackgroundImage(UIImage(named: "Map"), for: .normal)
		
		annotationView.markerTintColor = .corporativeColor
		annotationView.canShowCallout = true
		annotationView.calloutOffset = CGPoint(x: -5, y: 5)
		annotationView.rightCalloutAccessoryView = mapsButton
		annotationView.backgroundColor = .softBlue
		return annotationView
	}
	
	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		guard let place = view.annotation as? Annotation else { return }
		let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
		place.mapItem?.openInMaps(launchOptions: launchOptions)
	}
}
