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
	
	let kTestUserToken = UserDefaultsProvider.string(key: .authUserToken)
	
	// Registro de Usuario
	func register(newUser: NewUser, serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/register"
		
		AF.request(url, method: .post, parameters: newUser, encoder: JSONParameterEncoder.default).responseDecodable(of: Response.self, decoder: DateDecoder()) { response in
			
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
	
	// Upload User Image
	func uploadImage(userImage: URL, serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/getUploadImage"
		
		AF.upload(multipartFormData: { multipartformdata in
			multipartformdata.append(userImage, withName: "fileName")
		}, to: url, method: .post).responseDecodable(of: Response.self, decoder: DateDecoder()) {
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
	
	// Check If User Exists
	func checkUserExists(firstRegisterData: FirstRegisterDataModel, serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/checkIfUserExists"
		
		AF.request(url, method: .post, parameters: firstRegisterData, encoder: JSONParameterEncoder.default).responseDecodable(of: Response.self, decoder: DateDecoder()) {
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
	
	// Logeo de Usuario
	func login(userLogin: UserLogin, serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/login"
		
		AF.request(url, method: .post, parameters: userLogin, encoder: JSONParameterEncoder.default).responseDecodable(of: Response.self, decoder: DateDecoder()) {
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
	func userInfo(serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/userinfo"
		let headers: HTTPHeaders = [.authorization(bearerToken: kTestUserToken!)]
		
		AF.request(url, method: .get, headers: headers).responseDecodable(of: Response.self, decoder: DateDecoder()) { response in
			
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
	
	// Recuperar Contraseña
	func retrievePassword(email: String, serverResponse: @escaping (_ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()){
		let url = "\(Constants.kBaseURL)/recoverpass"
		
		AF.request(url, method: .post, parameters: ["email": email], encoding: JSONEncoding.default).responseDecodable(of: Response.self, decoder: DateDecoder()) {
			response in
			
			// Handle Response Data && Status Code && Message
			if let status = response.value?.status, let msg = response.value?.msg {
				serverResponse(status, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// Modificar Datos del Usuario
	func modifyData(userModify: NewUser, serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/usermodify"
		let headers: HTTPHeaders = [.authorization(bearerToken: kTestUserToken!)]
		
		AF.request(url, method: .post, parameters: userModify, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: Response.self, decoder: DateDecoder()) {
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
	
	// Modificar Contraseña
	func modifyPassword(newPassword: String, serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/passmodify"
		let headers: HTTPHeaders = [.authorization(bearerToken: kTestUserToken!)]
		
		AF.request(url, method: .post, parameters: ["password": newPassword], encoding: JSONEncoding.default, headers: headers).responseDecodable(of: Response.self, decoder: DateDecoder()) {
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
	
	// Registrar Un Club Como Favorito
	func registerFavClub(clubId: Int, serverResponse: @escaping (_ responseData: Data?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/registerfavclub"
		let headers: HTTPHeaders = [.authorization(bearerToken: kTestUserToken!)]
		
		AF.request(url, method: .post, parameters: ["club_id": clubId], encoding: JSONEncoding.default, headers: headers).responseDecodable(of: Response.self, decoder: DateDecoder()) {
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
	
	// Lista de Clubes
	func clubList(serverResponse: @escaping (_ responseData: [Data]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/listclubs"
		let headers: HTTPHeaders = [.authorization(bearerToken: kTestUserToken!)]
		
		AF.request(url, method: .get, headers: headers).responseDecodable(of: ListResponse.self, decoder: DateDecoder()) {
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
}


/**
 Registro de Usuarios: /register
 Login de Usuarios: /login
 Ver Perfil: /userinfo (Token)
 Recuperar Contraseña: /recoverpass
 Modificar Datos: /usermodify (Token)
 Modificar Contraseña: /passmodify (Token)
 Registar Club Como Favorito: /registerfavclub (Token)
 Upload Image: /getUploadImage
 CheckEmailFirstRegister: /checkIfUserExists
 
 Registro de Clubs: /registerclub
 Lista de Clubes: /listclubs (Token)
 */
