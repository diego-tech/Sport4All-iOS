//
//  InfoClubViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 15/2/22.
//

import UIKit
import MapKit
import CoreLocation

class InfoClubViewController: UIViewController {
	
	// MARK: Variables
	var club: Club?
	var location: Location?
	
	// MARK: Outlets
	@IBOutlet weak var headerUIView: UIView!
	@IBOutlet weak var webContactBTN: UIButton!
	@IBOutlet weak var phoneContactBTN: UIButton!
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
		
		locationMapView.delegate = self
		
		// Configure Models
		configure()
		
		// Configure Add Favourite Button
		addFavouriteButton.setImage(UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
		
		// Configure NavBar
		configureNavbar()
		
		// Inicialización Estilos
		buttonStyles()
		headerUIView.bottomShadow()
	}
	
	// MARK: Action Functions
	@IBAction func addToFavouriteButtonAction(_ sender: UIButton) {
		callAddToFavourite()
	}
	
	// MARK: Functions
	private func configure() {
		guard let club = club else { return debugPrint("Error Club") }
		guard let banner = club.club_banner else { return debugPrint("Error Banner") }
		guard let url = URL(string: Constants.kStorageURL + banner) else { return debugPrint("Error Url Imagen") }
		guard let description = club.description else { return debugPrint("Error Desc") }
		guard let services = club.services else { return debugPrint("Error Servicios") }
		guard let location = club.direction else { return debugPrint("Error Dirección") }
		
		self.clubTitleLabel.text = club.name
		self.clubBannerImageView.loadImage(fromURL: url, placeHolderImage: "HomeLogo")
		self.clubInfoTextView.text = description
		self.clubServicesStackView.setServicesInStackView(services: services, imageSize: CGRect(x: 0, y: 0, width: 50, height: 50))
		self.callFindLocation(locationName: location)
	}
	
	private func callFindLocation(locationName: String) {
		LocationProvider.shared.findLocation(with: locationName) { [weak self] location in
			DispatchQueue.main.async {
				self?.location = location
				self?.configureMapView()
			}
		}
	}
	
	private func callAddToFavourite() {
		guard let id = club?.id else { return }
		NetworkingProvider.shared.registerFavClub(clubId: id) { responseData, status, msg in
			self.addFavouriteButton.setImage(UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
			print(responseData)
			print(status)
			print(msg)
		} failure: { error in
			print(error)
		}
	}
	
	private func configureMapView() {
		guard let coordinates = location?.coordinates else { return }
		locationMapView.removeAnnotations(locationMapView.annotations)
		
		let pin = MKPointAnnotation()
		pin.coordinate = coordinates
		
		locationMapView.isZoomEnabled = false
		locationMapView.addAnnotation(pin)
		locationMapView.setRegion(MKCoordinateRegion(
			center: coordinates,
			span: MKCoordinateSpan(
				latitudeDelta: 0.001,
				longitudeDelta: 0.001)
		), animated: true)
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
		
		title = "INFORMACION"
		
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

extension InfoClubViewController: MKMapViewDelegate {
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "something")
		annotationView.markerTintColor = .corporativeColor
		return annotationView
	}
}
