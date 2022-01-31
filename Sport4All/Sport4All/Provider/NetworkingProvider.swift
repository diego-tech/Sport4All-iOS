//
//  NetworkingProvider.swift
//  Sport4All
//
//  Created by Diego Muñoz Herranz on 29/1/22.
//

import Foundation
import Alamofire

final class NetworkingProvider {
	static let shared = NetworkingProvider()
	
	// Registro de Usuario
	func register(newUser: NewUser, serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ message: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/register"
		
		AF.request(url, method: .post, parameters: newUser, encoder: JSONParameterEncoder.default).validate(statusCode: Constants.kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) { response in
			
			// Handle Response Data && Status Code && Message
			if let data = response.value?.data, let status = response.value?.status, let msg = response.value?.msg {
				serverResponse(data, status, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Logeo de Usuario
	func login(userLogin: UserLogin, serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ message: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/login"
		
		AF.request(url, method: .post, parameters: userLogin, encoder: JSONParameterEncoder.default).validate(statusCode: Constants.kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) {
			response in
			
			// Handle Response Data && Status Code && Message
			if let data = response.value?.data, let status = response.value?.status, let msg = response.value?.msg {
				serverResponse(data, status, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Ver Perfil
	func userInfo(serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ message: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		
		let url = "\(Constants.kBaseURL)/userinfo"
		let headers: HTTPHeaders = [.authorization(bearerToken: "16|4EVz5jhR6eg5PmiwiwZrIlomKWM74hUeHxjcxImv")]
		
		AF.request(url, method: .get, headers: headers).validate(statusCode: Constants.kStatusCode).responseDecodable(of: Response.self, decoder: DateDecoder()) { response in
			
			// Handle Response Data && Status Code && Message
			if let data = response.value?.data, let status = response.value?.status, let msg = response.value?.msg {
				serverResponse(data, status, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
}


/**
 Registro de Usuarios: /register
 Login de Usuarios: /login
 Ver Perfil: /userinfo
 Recuperar Contraseña: /recoverpass
 Modificar Datos: /usermodify
 Modificar Contraseña: /passmodify
 Registro de Clubs: /registerclub
 Lista de Clubes: /listclubs
 Registar Club Como Favorito: /registerfavclub
 */
