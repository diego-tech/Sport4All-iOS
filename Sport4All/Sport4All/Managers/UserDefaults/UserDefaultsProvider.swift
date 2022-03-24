//
//  UserDefaultsProvider.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 29/1/22.
//

import Foundation

enum UserDefaultsKey: String {
	case authUserToken
	case authUserName
	case authUserSurname
	case authUserEmail
	case authUserImg
	case authUserGenre
	case isNewUser
	case isNewUserEdit
}

final class UserDefaultsProvider {
	static let shared = UserDefaultsProvider()
	
	// Set User Default Key
	func setUserDefaults(key: UserDefaultsKey, value: Any) {
		let standard = UserDefaults.standard
		standard.set(value, forKey: key.rawValue)
		standard.synchronize()
	}
	
	// Remove One User Default
	func remove(key: UserDefaultsKey) {
		let standard = UserDefaults.standard
		standard.removeObject(forKey: key.rawValue)
		standard.synchronize()
	}
	
	func string(key: UserDefaultsKey) -> String? {
		return UserDefaults.standard.string(forKey: key.rawValue)
	}
	
	func bool(key: UserDefaultsKey) -> Bool {
		return UserDefaults.standard.bool(forKey: key.rawValue)
	}
	
	// Remove All User Defaults
	func clearUserDefaults() {
		let standard = UserDefaults.standard
		standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
		standard.synchronize()
	}
}
