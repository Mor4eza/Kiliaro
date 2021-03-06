//
//  Network.swift
//  Kiliaro
//
//  Created by Morteza on 11/20/21.
//

import Foundation

protocol NetworkClient {
    var session: URLSession { get }
    func request<T: Requestable>(req: T, _ completion: @escaping (Result<T.ResponseType, Error>) -> Void)
}

class Network: NetworkClient {
    
    var session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func request<T: Requestable>(req: T, _ completion: @escaping (Result<T.ResponseType, Error>) -> Void) {
        
        let request = prepareRequest(req)
        session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    if let data = data {
                        let decoder = JSONDecoder()
                        if let decodedRespose = try? decoder.decode(T.ResponseType.self, from: data) {
                            DispatchQueue.main.async {
                                completion(.success(decodedRespose))
                            }
                        } else {
                            completion(.failure(NSError(domain: "serializeError", code: -1, userInfo: ["serializedError": -1])))
                        }
                    }
                } else {
                    let httpError = NSError(domain: "code", code: response.statusCode, userInfo: ["code": response.statusCode])
                    completion(.failure(httpError))
                }
            }
            
        }.resume()
        
    }
}

extension Network {
    private func prepareRequest<T: Requestable>(_ req: T) -> URLRequest {
        
        let url = URL(string: AppConstant.baseURL + req.path)!
        var request = URLRequest(url: url)
        request.httpMethod = req.method.rawValue
        
        if req.method == .post {
            let jsonData = try? JSONSerialization.data(withJSONObject: req.parameters, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        return request
    }
}
