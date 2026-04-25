//
//  APIManager.swift
//  SquareGitRepo
//
//  Created by RV on 25/04/26.
//

import Foundation
import UIKit

protocol APIManaging {
    func post(params: [String: Any], url: String, accessTokenValue: String, completionHandler: @escaping (Data?, String?) -> Void)
    func get(params: [String: String], url: String, accessTokenValue: String, completionHandler: @escaping (Data?, String?) -> Void)
}

class APIManager: APIManaging {
    
    enum RequestType: String {
        case POST = "POST"
        case GET = "GET"
    }
    
    static let sharedInstance: APIManager = APIManager()
    init() {
        
    }
    
    func isInternetAvailable() -> Bool
    {
        if NetworkCheck.shared.isConnected {
            // internet available
            return true
        }
        // no internet
        return false
    }
    
    func post(params : Dictionary<String, Any>, url : String, accessTokenValue: String, completionHandler:@escaping (_ dataValue: Data?, String?) -> Void) {
        let strUrl = url
        
        let apiRequest = getRequestFor(stringUrl: strUrl, requestType: .POST, authValue: accessTokenValue, params: params)
        guard isInternetAvailable() else {
            completionHandler(nil, ErrorMessages.ServerError.NoInternet)
            return
        }
        guard let request = apiRequest else {
            completionHandler(nil, ErrorMessages.ServerError.responseErrorTryAgain)
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                ////print(error ?? "Something went wrong")
                completionHandler(nil, error?.localizedDescription)
            } else {
                guard let data = data else {
                    completionHandler(nil,"Data not found. Please try again.")
                    return
                }
                //TODO: To Check API Response Data
                self.checkActualResponse(data: data)
                if data.count != 0 {
                    completionHandler(data, nil)
                } else {
                    completionHandler(nil, ErrorMessages.ServerError.responseErrorTryAgain)
                }
            }
        })
        
        dataTask.resume()
        
    }
    
    func get(params : Dictionary<String, String>, url : String, accessTokenValue: String, completionHandler:@escaping (_ dataValue: Data?, String?) -> Void) {
        
        guard isInternetAvailable() else {
            completionHandler(nil, ErrorMessages.ServerError.NoInternet)
            return
        }
        //To check the parameter if required at any point
        //let requestBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        //--
        var components = URLComponents(string: url)!

        var queryItemvalues = [URLQueryItem]()
        for (key, value) in params {
            let queryItem = URLQueryItem(name: key, value: value)
            queryItemvalues.append(queryItem)
        }
        if queryItemvalues.count > 0 {
            components.queryItems = queryItemvalues
        }

        guard let requestUrl = components.url else {
            completionHandler(nil, "Please try again.")
            return
        }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        if accessTokenValue != "" {
            request.addValue("Bearer \(accessTokenValue)", forHTTPHeaderField: "Authorization")
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            //guard let self = self else { return }
            if (error != nil) {
                ////print(error ?? "Something went wrong")
                completionHandler(nil, error?.localizedDescription)
            } else {
                let httpResponse = response as? HTTPURLResponse
                
                if let errorCode = httpResponse?.statusCode as? Int {
                    if errorCode == 401 {
                        completionHandler(nil, "Unauthorized User")
                        return
                    }
                }
                
                guard let data = data else {
                    completionHandler(nil,"Data not found. Please try again.")
                    return
                }
                //TODO: To Check API Response Data
                //self.checkActualResponse(data: data)
                if data.count != 0 {
                    completionHandler(data, nil)
                } else {
                    completionHandler(nil, ErrorMessages.ServerError.responseErrorTryAgain)
                }
                
            }
        })
        
        dataTask.resume()
    }
    
    func getRequestFor(stringUrl: String, requestType: RequestType, authValue: String, params : Dictionary<String, Any>) -> URLRequest? {
        
        guard let requestBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) else {
            return nil
        }
        guard let requestUrl = URL(string: stringUrl) else
        {
            return nil
        }
        var request = URLRequest(url: requestUrl)
        
        request.httpMethod = requestType.rawValue
        guard let json = NSString(data: requestBody, encoding: String.Encoding.utf8.rawValue) else {
            return nil
        }
        request.httpBody = json.data(using: String.Encoding.utf8.rawValue)
        
        //Authorization: Bearer {your_access_token}
        if authValue != "" {
            request.addValue("Bearer \(authValue)", forHTTPHeaderField: "Authorization")
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    func checkActualResponse(data: Data) {
        do {
            var jsonDict = [String: Any]()
            var jsonArray = [Any]()
            if let jsonAsDict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                jsonDict = jsonAsDict
                print("Response Dictionary: \(jsonDict)")
                if let statusCode = jsonDict["statusCode"] as? Int {
                    let message = jsonDict["message"] as? String
                    if statusCode == 401 {
                        print(message ?? "Unauthorized User. Please check your Login credentials and try again.")
                        return
                    }
                }
            } else if let jsonAsArray = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any] {
                jsonArray = jsonAsArray
                print("Response Array: \(jsonArray)")
            } else {
                print("Unable to Format the Data")
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
