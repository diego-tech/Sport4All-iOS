//
//  UserDefaultsProvider.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 29/1/22.
//

import Foundation

enum UserDefaultsKey: String {
	case authUserToken
	case isNewUser
}

final class UserDefaultsProvider {
	
	// Set User Default Key
	static func setUserDefaults(key: UserDefaultsKey, value: Any) {
		let standard = UserDefaults.standard
		standard.set(value, forKey: key.rawValue)
		standard.synchronize()
	}
	
	// Remove One User Default
	static func remove(key: UserDefaultsKey) {
		let standard = UserDefaults.standard
		standard.removeObject(forKey: key.rawValue)
		standard.synchronize()
	}
	
	static func string(key: UserDefaultsKey) -> String? {
		return UserDefaults.standard.string(forKey: key.rawValue)
	}
	
	static func bool(key: UserDefaultsKey) -> Bool {
		return UserDefaults.standard.bool(forKey: key.rawValue)
	}
	
	// Remove All User Defaults
	static func clearUserDefaults() {
		let standard = UserDefaults.standard
		standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
		standard.synchronize()
	}
}
