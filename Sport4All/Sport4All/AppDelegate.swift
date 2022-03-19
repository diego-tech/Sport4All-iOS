//
//  AppDelegate.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit
import IQKeyboardManagerSwift
import Alamofire
import SPIndicator

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")

		reachabilityManager?.startListening { status in
			switch status {
			case .notReachable:
				print("No Internet")
				let indicatorView = SPIndicatorView(title: "No Tienes Conexión a Internet", preset: .error)
				indicatorView.present(duration: 3)
			case .unknown:
				print("Unknown")
				let indicatorView = SPIndicatorView(title: "No Tienes Conexión a Internet", preset: .error)
				indicatorView.present(duration: 3)
			case .reachable(.cellular):
				print("Cellular")
			case .reachable(.ethernetOrWiFi):
				print("Wifi")
			}
		}
		
		// Tiempo de Cargar Launch Screen
		Thread.sleep(forTimeInterval: 2.0)
				
		// Inicializar IQKeyboardManager
		IQKeyboardManager.shared.enable = true
		IQKeyboardManager.shared.enableAutoToolbar = false

		// Override point for customization after application launch.
		return true
	}

	// MARK: UISceneSession Lifecycle

	func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
		// Called when a new scene session is being created.
		// Use this method to select a configuration to create the new scene with.
		return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
	}

	func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
		// Called when the user discards a scene session.
		// If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
		// Use this method to release any resources that were specific to the discarded scenes, as they will not return.
	}
    
    
  
    
    
    
    
    
    
    
    
    
    


}

