//
//  APIClient.swift
//  SonyLIV
//
//  Created by Aravind Kumar on 17/09/21.
//

import UIKit
class Network {
    struct ENDPOINT {
        private static let URL = "https://api.punkapi.com/"
        public static var BASE_DATA_URL:String{
            get{
                return URL
            }
        }
    }
   enum AVAIL_VER:Int {
        case V1 = 1
        case V2 = 2
    }
}
enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .responseUnsuccessful: return "Response Unsuccessful"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .jsonConversionFailure: return "JSON Conversion Failure"
        }
    }
}
enum Result<T, U> where U: Error,T:Decodable {
    case success(T)
    case failure(U)
}
protocol APIClient:Decodable {
    var pageNumber:Int { get set }
    func getParameters() -> [String:Any]
    func getBaseUrlPath() -> String
    func fetchDataModel<T>(completion:@escaping (Result<T, APIError>) -> Void)
    
}
extension APIClient {
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    func getDataObject<T: Decodable>(url:String,decodingType: T.Type, parametrs:[String:Any], completion: @escaping  JSONTaskCompletionHandler) {
        print("Aravind -> \(url)")
        URLSession.shared.dataTask(with: URL(string: url)!) { (data, resp, err) in
            if let data = data {
                let str = String(decoding: data, as: UTF8.self)
                print(str)
                do {
                    let genericModel = try! JSONDecoder().decode(decodingType, from: data)
                    completion(genericModel, nil)
                } catch {
                    completion(nil, .jsonConversionFailure)
                }
            } else {
                completion(nil, .invalidData)
            }
            
        }.resume()
    }
    func fetchDataModel<T: Decodable>(completion:@escaping (Result<T, APIError>) -> Void){
        
        getDataObject(url:self.getBaseUrlPath(),decodingType:T.self, parametrs: self.getParameters()) { (json , error) in
            //MARK: change to main queue
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        completion(Result.failure(.invalidData))
                    }
                    return
                }
                if let value = json as? T {
                    completion(.success(value))
                }
                else {
                    completion(.failure(.jsonParsingFailure))
                }
            }
        }
    }
}
