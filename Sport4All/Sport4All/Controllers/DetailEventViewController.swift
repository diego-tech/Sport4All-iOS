//
//  DetailEventViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 19/2/22.
//

import UIKit
import MapKit
import Contacts

class DetailEventViewController: UIViewController {
	
	// MARK: Variables
	var event: Event?
	var location: Location?
	
	// MARK: Outlets
	@IBOutlet weak var eventNameLabel: UILabel!
	@IBOutlet weak var eventImageView: LazyImageView!
	@IBOutlet weak var eventDayLabel: UILabel!
	@IBOutlet weak var infoEventTextView: UITextView!
	@IBOutlet weak var clubDirection: MKMapView!
	@IBOutlet weak var inscribeEventBTN: UIButton!
	@IBOutlet weak var headerUIView: UIView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		clubDirection.delegate = self
		
		// Configure Navbar
		configureNavbar()
		
		// Inicialización Estilos
		inscribeButtonStyle()
		headerUIView.bottomShadow()
		
		// Configure View
		configure()
	}
	
	// MARK: Action Functions
	
	// MARK: Functions
	private func configure() {
		guard let event = event else { return }
		guard let event_img = event.img else { return }
		guard let event_desc = event.description else { return }
		guard let location = event.clubLocation else { return }
		guard let eventName = event.name else { return }
		guard let eventUrl = URL(string: Constants.kStorageURL + event_img) else { return }
		guard let date = event.finalDate else { return }
		
		self.eventDayLabel.text = dateFormatter(day: date)
		self.eventImageView.loadImage(fromURL: eventUrl)
		self.eventNameLabel.text = eventName
		self.infoEventTextView.text = event_desc
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
	
	private func configureMapView() {
		clubDirection.removeAnnotations(clubDirection.annotations)
		guard let coordinates = location?.coordinates else { return }
		guard let locationName = location?.title else { return }
		guard let placeName = event?.clubName else { return }
		
		let annotation = Annotation(coordinate: coordinates, title: placeName, subtitle: locationName)
		clubDirection.isZoomEnabled = false
		clubDirection.isScrollEnabled = false
		clubDirection.isPitchEnabled = false
		clubDirection.isRotateEnabled = false
		clubDirection.addAnnotation(annotation)
		clubDirection.setRegion(MKCoordinateRegion(
			center: coordinates,
			span: MKCoordinateSpan(
				latitudeDelta: 0.01,
				longitudeDelta: 0.01)
		), animated: true)
	}
	
	private func dateFormatter(day: String) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
		let dateF = formatter.date(from: day)
		
		guard let formatDate = dateF else { return "Error" }
		formatter.locale = Locale(identifier: "es_Es")
		formatter.dateFormat = "dd MMMM yyyy HH:mm"
		let finalDate = formatter.string(from: formatDate)
		
		return "- Día \(finalDate)"
	}
	
	// MARK: Styles
	private func inscribeButtonStyle() {
		inscribeEventBTN.round()
		inscribeEventBTN.colors()
	}
	
	private func configureNavbar() {
		self.navigationController?.navigationBar.titleTextAttributes = [
			.foregroundColor: UIColor.corporativeColor ?? .black,
			.font: UIFont(name: FontType.SFProDisplayBold.rawValue, size: 22) ?? .systemFont(ofSize: 22, weight: .bold)
		]
		
		title = "EVENTO"
		
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

extension DetailEventViewController: MKMapViewDelegate {
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
