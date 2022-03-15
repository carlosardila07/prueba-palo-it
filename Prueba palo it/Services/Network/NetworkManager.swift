//
//  NetworkManager.swift
//  Prueba palo it
//
//  Created by Carlos Ardila on 14/03/22.
//

import Alamofire
import PromiseKit

struct NetworkManager {
    static let shared: NetworkManager = {
        return NetworkManager()
    }()
    
    let baseURL = "https://jsonplaceholder.typicode.com/"
    
    let serverErrorMessage = "Error de servidor"
    let defaultHeaders: HTTPHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]
    
    func arrayRequest<Result: Codable> (_ route: String, method: HTTPMethod = .get, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default) -> Promise<[Result]> {
        let completeUrl = self.baseURL + route
        return Promise <[Result]> { seal in
            let request = AF.request(completeUrl, method: method, parameters: parameters, encoding: encoding, headers: defaultHeaders)
            request.responseDecodable(completionHandler: { (result: DataResponse<[Result], AFError>) -> Void in
                if let error = result.error {
                    let customError = CustomError(title: nil, description: error.errorDescription ?? self.serverErrorMessage, code: 500)
                    seal.reject(customError)
                } else {
                    seal.resolve(result.value, nil)
                }
            })
        }
    }
}
