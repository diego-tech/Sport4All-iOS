//
//  SceneDelegate.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 10/1/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	
	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		// Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
		// If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
		// This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
		guard let _ = (scene as? UIWindowScene) else { return }
		
		let userDefaultsToken: String = UserDefaultsProvider.shared.string(key: .authUserToken) ?? ""
		
		/* Lanzar Onboarding */
		if !UserDefaultsProvider.shared.bool(key: .isNewUser) {
			// Show Onboarding
			let vc = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
			vc.modalPresentationStyle = .automatic
			vc.modalType = .firstLogin
			window?.rootViewController = vc
		}
		
		// Show differents view controller if user has token or not
		if userDefaultsToken != "" {
			// Show Home Controller
			let vc = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBar")
			vc.modalPresentationStyle = .automatic
			vc.modalTransitionStyle = .coverVertical
			window?.rootViewController = vc
		} else {
			// Show Auth Controller
			let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! AuthViewController
			vc.modalPresentationStyle = .automatic
			vc.modalTransitionStyle = .coverVertical
			window?.rootViewController = vc
		}
				
		window?.makeKeyAndVisible()
	}
	
	/// Change Root View Controller
	/// - Parameters:
	///   - vc: The view controller to go when call this function
	///   - animated: If you have animation or not
	func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
		guard let window = self.window else { return }
		
		window.rootViewController = vc
		
		UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: nil, completion: nil)
	}
	
	func sceneDidDisconnect(_ scene: UIScene) {
		// Called as the scene is being released by the system.
		// This occurs shortly after the scene enters the background, or when its session is discarded.
		// Release any resources associated with this scene that can be re-created the next time the scene connects.
		// The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
	}
	
	func sceneDidBecomeActive(_ scene: UIScene) {
		// Called when the scene has moved from an inactive state to an active state.
		// Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
	}
	
	func sceneWillResignActive(_ scene: UIScene) {
		// Called when the scene will move from an active state to an inactive state.
		// This may occur due to temporary interruptions (ex. an incoming phone call).
	}
	
	func sceneWillEnterForeground(_ scene: UIScene) {
		// Called as the scene transitions from the background to the foreground.
		// Use this method to undo the changes made on entering the background.
	}
	
	func sceneDidEnterBackground(_ scene: UIScene) {
		// Called as the scene transitions from the foreground to the background.
		// Use this method to save data, release shared resources, and store enough scene-specific state information
		// to restore the scene back to its current state.
	}
	
	
}

