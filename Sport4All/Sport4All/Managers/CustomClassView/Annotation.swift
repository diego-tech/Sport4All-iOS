//
//  Annotation.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 19/3/22.
//

import Foundation
import MapKit
import Contacts

// MARK: Annotation Class
class Annotation: NSObject, MKAnnotation {
	var coordinate: CLLocationCoordinate2D
	var title: String?
	var subtitle: String?
	
	init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
		self.coordinate = coordinate
		self.title = title
		self.subtitle = subtitle
		
		super.init()
	}
	
	var mapItem: MKMapItem? {
		guard let location = title else { return nil }
		let addressDict = [CNPostalAddressStreetKey: location]
		let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
		let mapItem = MKMapItem(placemark: placemark)
		mapItem.name = title
		return mapItem
	}
}
