//
//  PendingEventsViewController.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 23/2/22.
//

import UIKit
import MapKit
import Contacts

class PendingEventsViewController: UIViewController {
	
	// MARK: Variables
	var pendingEvent: PendingOrFinishEvent?
	var pendingType: PendingType?
	var barcode: String?
	var location: Location?
	
	// MARK: Outlets
	@IBOutlet weak var headerUIView: UIView!
	@IBOutlet weak var barcodeImageView: UIImageView!
	@IBOutlet weak var mapView: MKMapView!
	@IBOutlet weak var eventHeaderUIView: UIView!
	@IBOutlet weak var eventImageView: LazyImageView!
	@IBOutlet weak var headerTitleLabel: UILabel!
	@IBOutlet weak var courtInfoLabel: UILabel!
	@IBOutlet weak var courtLabel: UILabel!
	
	override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		// Map View Delegate
		mapView.delegate = self
		
		// Configure Navbar
		configureNavbar()
		
		// Inicialización de Estilos
		headerUIView.bottomShadow()
		eventHeaderUIView.bottomShadow()
		barcodeIVStyle()
		
		// Barcode Image View Action
		let gesture = UITapGestureRecognizer(target: self, action: #selector(barcodeTapped))
		barcodeImageView.isUserInteractionEnabled = true
		barcodeImageView.addGestureRecognizer(gesture)
		
		// Configure
		configure()
    }
	
	// MARK: Action Functions
	@objc func barcodeTapped() {
		let vc = UIStoryboard(name: "QrDetail", bundle: nil).instantiateViewController(withIdentifier: "QRDetail") as! QRDetailViewController
		guard let barcode = barcode else { return }
		vc.qrCode = barcode
		present(vc, animated: true)
	}
	
	// MARK: Functions
	private func configure() {
		switch pendingType {
		case .event:
			configurePendingEvent()
			print("Evento")
		case .match:
			configurePendingMatchOrReserve()
			print("Partido")
		case .reserve:
			configurePendingMatchOrReserve()
			print("Reserva")
		default:
			break
		}
	}
	
	private func configurePendingEvent() {
		self.headerUIView.isHidden = true
		
		guard let pendingEvent = pendingEvent else { return debugPrint("Error Evento") }
		guard let eventImage = pendingEvent.eventImg else { return debugPrint("Error Event Image") }
		guard let imgUrl = URL(string: Constants.kStorageURL + eventImage) else { return debugPrint("Error Event URL Image") }
		guard let eventName = pendingEvent.eventName else { return debugPrint("Error Nombre de Evento") }
		guard let pedingLocation = pendingEvent.clubLocation else { return debugPrint("Error Location") }
		
		print("Location \(pedingLocation)")
		self.eventImageView.loadImage(fromURL: imgUrl)
		self.headerTitleLabel.text = eventName
		self.callFindLocation(locationName: pedingLocation)
	}
	
	private func configurePendingMatchOrReserve() {
		self.eventHeaderUIView.isHidden = true
		
		guard let pendingEvent = pendingEvent else { return debugPrint("Error Evento") }
		guard let pendingBarcode = pendingEvent.qr else { return debugPrint("Error Qr") }
		guard let pendingTitle = pendingEvent.clubName else { return }
		guard let pendingCourt = pendingEvent.courtName else { return }
		guard let pendingTypeCourt = pendingEvent.courtType else { return }
		guard let location = pendingEvent.clubLocation else { return }
		print("Location \(location)")

		self.barcode = pendingBarcode
		
		self.barcodeImageView.image = AuxFunctions.generateQRCodeImage(reservationCode: pendingBarcode)
		self.headerTitleLabel.text = pendingTitle
		self.courtLabel.text = "- \(pendingCourt) (\(pendingTypeCourt))"
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
		mapView.removeAnnotations(mapView.annotations)
		guard let coordinates = location?.coordinates else { return }
		guard let locationName = location?.title else { return }
		guard let pendingEvent = pendingEvent else { return debugPrint("Error Evento") }
		
		guard let placeName = pendingEvent.clubName else { return }
		
		let annotation = Annotation(coordinate: coordinates, title: placeName, subtitle: locationName)
		mapView.isZoomEnabled = false
		mapView.isScrollEnabled = false
		mapView.isPitchEnabled = false
		mapView.isRotateEnabled = false
		mapView.addAnnotation(annotation)
		mapView.setRegion(MKCoordinateRegion(
			center: coordinates,
			span: MKCoordinateSpan(
				latitudeDelta: 0.01,
				longitudeDelta: 0.01)
		), animated: true)
	}
	
	// MARK: Styles
	private func barcodeIVStyle() {
		barcodeImageView.frame = CGRect(x: 0, y: 0, width: 175, height: 175)
		barcodeImageView.layer.magnificationFilter = CALayerContentsFilter.nearest
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

// MARK: MKMapView Extension
extension PendingEventsViewController: MKMapViewDelegate {
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
