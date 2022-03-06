//
//  LocationProvider.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 6/3/22.
//

import Foundation
import CoreLocation

struct Location {
	let title: String
	let coordinates: CLLocationCoordinate2D?
}

final class LocationProvider: NSObject {
	static let shared = LocationProvider()
	
	func findLocation(with locationName: String, completion: @escaping ((Location) -> Void)) {
		let geoCoder = CLGeocoder()
		
		geoCoder.geocodeAddressString(locationName) { places, error in
			guard let places = places, error == nil else {
				return
			}
			
			let place = places.first
			let coordinate = place?.location?.coordinate
			var locationName = ""
			
			if let placeName = place?.name, let adminRegion = place?.administrativeArea {
				locationName = "\(placeName), \(adminRegion)"
			}
			
			let result = Location(title: locationName, coordinates: coordinate)
			completion(result)
		}
	}
}
