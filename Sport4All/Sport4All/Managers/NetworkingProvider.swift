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
	
	let kUserToken = UserDefaultsProvider.shared.string(key: .authUserToken)
	
	// MARK: Register User
	func register(newUser: NewUser, serverResponse: @escaping (_ responseData: User?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
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
	
	// MARK: Upload Image
	func uploadImage(userImage: URL, serverResponse: @escaping (_ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/getUploadImage"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.upload(multipartFormData: { multipartformdata in
			multipartformdata.append(userImage, withName: "fileName")
		}, to: url, method: .post, headers: headers).responseDecodable(of: UploadImageResponse.self, decoder: DateDecoder()) {
			response in
			
			// Handle Status Code && Message
			if let status = response.value?.status, let msg = response.value?.msg {
				serverResponse(status, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// MARK: User Login
	func login(userLogin: UserLogin, serverResponse: @escaping (_ responseData: User?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
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
	
	// MARK: Show Profile
	func userInfo(serverResponse: @escaping (_ responseData: User?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/userinfo"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
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
	
	// MARK: Retrieve Password
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
	
	// MARK: Modify Data
	func modifyData(userModify: NewUser, serverResponse: @escaping (_ responseData: User?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/usermodify"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
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
	
	// MARK: Modify Password
	func modifyPassword(newPassword: String, serverResponse: @escaping (_ responseData: User?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/passmodify"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
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
	
	// MARK: Favourite Club
	func registerFavClub(clubId: Int, serverResponse: @escaping (_ responseData: User?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/registerfavclub"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
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
	
	// MARK: List Club
	func clubList(serverResponse: @escaping (_ responseData: [Club]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/listclubs"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, headers: headers).responseDecodable(of: ClubListResponse.self, decoder: DateDecoder()) {
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
	
	
	// MARK: Most Rated List
	func mostRatedList(serverResponse: @escaping (_ responseData: [Club]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/mostrated"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, headers: headers).responseDecodable(of: ClubListResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: Club Favourite Clubs	
	func clubFavouriteList(serverResponse: @escaping (_ responseData: [Club]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/listfavs"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, headers: headers).responseDecodable(of: ClubListResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: Search Club
	func searchClubs(with query: String, serverResponse: @escaping (_ responseData: [Club]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/searchclubs"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, parameters: ["name": query], headers: headers).responseDecodable(of: ClubListResponse.self, decoder: DateDecoder()) {
			response in
			
			// Handel Response Data && Status Code && Message
			if let data = response.value?.data, let status = response.value?.status, let msg = response.value?.msg {
				serverResponse(data, status, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// MARK: Remove Favourite Club
	func deleteFavouriteClub(clubId: Int, serverResponse: @escaping (_ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/deletefav"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]

		AF.request(url, method: .delete, parameters: ["club_id": clubId], encoding: JSONEncoding.default, headers: headers).responseDecodable(of: Response.self, decoder: DateDecoder()) {
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
	
	// MARK: Free Courts
	func freeCourts(courtsParameters: QueryCourt, serverResponse: @escaping (_ responseData: [Court]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/freecourts"
		let header: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		let parameters = [
			"club_id": courtsParameters.club_id,
			"day": courtsParameters.day,
			"hour": courtsParameters.hour
		] as [String : Any]
		
		AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: header).responseDecodable(of: FreeCourtsResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: List All Events
	func listEvents(serverResponse: @escaping (_ responseData: [Event]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/listevents"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, headers: headers).responseDecodable(of: EventListResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: List Events For Fav Clubs
	func listEventsByFav(serverResponse: @escaping (_ responseData: [Event]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/listfavouritegevents"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, headers: headers).responseDecodable(of: EventListResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: Pending Events List
	func pendingEvents(serverResponse: @escaping (_ responseData: [PendingOrFinishEvent]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/pendingevents"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, headers: headers).responseDecodable(of: PendingOrFinishListResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: Pending Matches List
	func pendingMatches(serverResponse: @escaping (_ responseData: [PendingOrFinishEvent]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/pendingmatches"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, headers: headers).responseDecodable(of: PendingOrFinishListResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: Pending Reserves
	func pendingReserves(serverResponse: @escaping (_ responseData: [PendingOrFinishEvent]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/pendingreserves"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, headers: headers).responseDecodable(of: PendingOrFinishListResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: Finish Events List
	func finishEvents(serverResponse: @escaping (_ responseData: [PendingOrFinishEvent]?, _ status: Int?, _ msg: String?) ->(), failure: @escaping (_ error: Error?) ->()) {
		let url = "\(Constants.kBaseURL)/endedevents"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, headers: headers).responseDecodable(of: PendingOrFinishListResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: Finish Match List
	func finishMatch(serverResponse: @escaping (_ responseData: [PendingOrFinishEvent]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/endedmatches"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, headers: headers).responseDecodable(of: PendingOrFinishListResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: Finish Reserve List
	func finishReserve(serverResponse: @escaping (_ responseData: [PendingOrFinishEvent]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/endedreserves"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, headers: headers).responseDecodable(of: PendingOrFinishListResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: See Matches
	func matches(day: String, serverResponse: @escaping (_ responseData: [Match]?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/seematches"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		let parameters = [
			"day": day
		] as [String : Any]
		
		AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseDecodable(of: MatchListResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: Court Reserve
	func courtReserve(reserveQuery: ReserveQuery, serverResponse: @escaping (_ responseData: Reserve?, _ status: Int?, _ msg: String?) ->(), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/courtreserve"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		let parameters = [
			"club_id": reserveQuery.club_id,
			"court_id": reserveQuery.court_id,
			"lights": reserveQuery.lights,
			"day": reserveQuery.day,
			"start_time": reserveQuery.start_time,
			"time": reserveQuery.time
		] as [String : Any]
		
		AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseDecodable(of: ReserveResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: Match Inscription
	func matchInscription(match_id: Int, serverResponse: @escaping (_ responseData: MatchInscription?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/matchinscription"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		let parameters = [
			"match_id": match_id
		] as [String: Int]
		
		AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseDecodable(of: MatchInscriptionResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: Join Event
	func joinEvent(event_id: Int, serverResponse: @escaping (_ responseData: Inscription?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/joinevent"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		let parameters = [
			"id": event_id
		] as [String: Any]
		
		AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseDecodable(of: InscriptionEventResponse.self, decoder: DateDecoder()) {
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
	
	// MARK: Logout
	func logOut(serverResponse: @escaping (_ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/logout"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .post, headers: headers).responseDecodable(of: LogOutResponse.self, decoder: DateDecoder()) {
			response in
			
			// Handle Response Status Code && Message
			if let status = response.value?.status, let msg = response.value?.msg {
				serverResponse(status, msg)
			}
			
			// Handle Alamofire Error
			if let error = response.error {
				failure(error)
			}
		}
	}
	
	// MARK: Info Club
	func infoClub(club_id: Int, serverResponse: @escaping (_ responseData: Club?, _ status: Int?, _ msg: String?) -> (), failure: @escaping (_ error: Error?) -> ()) {
		let url = "\(Constants.kBaseURL)/endedinfoclub"
		let headers: HTTPHeaders = [.authorization(bearerToken: UserDefaultsProvider.shared.string(key: .authUserToken)!)]
		
		AF.request(url, method: .get, parameters: ["id": club_id], encoding: URLEncoding.default, headers: headers).responseDecodable(of: InfoClubResponse.self, decoder: DateDecoder()) {
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
