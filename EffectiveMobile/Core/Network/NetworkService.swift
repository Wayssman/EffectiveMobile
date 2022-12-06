//
//  NetworkService.swift
//  EffectiveMobile
//
//  Created by Alexandr on 06.12.2022.
//

import Foundation

protocol NetworkServiceInterface {
    func request<Response: Decodable>(
        endpoint: EndpointProtocol,
        completion: @escaping (APIResult<Response>) -> Void
    )
}

final class NetworkService {
    // MARK: Properties
    private let session: URLSession
    
    // MARK: Initializers
    init() {
        self.session = URLSession(configuration: Constans.API.sessionConfiguration)
    }
    
    // MARK: Internal
    private func commonRequest(
        endpoint: EndpointProtocol,
        completion: @escaping (DataTaskResult) -> Void
    ) {
        guard let url = constructUrl(path: endpoint.path) else {
            completion(.failure(.noUrl))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.nilResponse))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(.serverError(response.statusCode)))
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                completion(.failure(.mimeError))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
    
    private func constructUrl(path: String) -> URL? {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = Constans.API.devHost
        urlConstructor.path = [Constans.API.devApiVersion, path].joined(separator: "/")
        
        return urlConstructor.url
    }
    
    private func map<Model: Decodable>(from data: Data?) -> APIResult<Model> {
        guard let data = data else {
            return .failure(.noDataError)
        }
        
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
        } catch {
            return .failure(.jsonError(error))
        }
        
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(Model.self, from: data)
            return .success(result)
        } catch {
            return .failure(.parseError(error))
        }
    }
}

// MARK: - NetworkServiceInterface
extension NetworkService: NetworkServiceInterface {
    func request<Response: Decodable>(
        endpoint: EndpointProtocol,
        completion: @escaping (APIResult<Response>) -> Void
    ) {
        commonRequest(endpoint: endpoint) { taskResult in
            let result: APIResult<Response>
            
            switch taskResult {
            case .success(let data):
                result = self.map(from: data)
            case .failure(let error):
                result = .failure(error)
            }
            
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
