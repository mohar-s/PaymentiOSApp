//
//  LoginService.swift
//  PaymentApp
//
//  Created by Mohar on 10/12/24.
//

import Foundation

struct LoginService {

    // Call Login api to fetch the user data
    func callLoginAPI(
        from url: String, username: String, password: String,
        completion: @escaping (LoginData?) -> Void ) {
            
            let Url = String(format: url)
            guard let serviceUrl = URL(string: Url) else { return // Later : throw erorr
            }
            let parameterDictionary = [
                "username": username, "password": password, "expiresInMins": "30",
            ]
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            guard
                let httpBody = try? JSONSerialization.data(
                    withJSONObject: parameterDictionary, options: [])
            else {
                return // Later : throw erorr
            }
            request.httpBody = httpBody
            
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        
                        // Serialization data
                        let json = try JSONSerialization.jsonObject(
                            with: data, options: [])
                        print("response Login data:", json)
                        
                        // Decode the Response and create the login data object
                        let loginData = try JSONDecoder().decode(
                            LoginData.self, from: data)
                        
                        // return the Response to main method
                        completion(loginData)
                        
                    } catch {
                        
                        // return the enpty to main method
                        completion(nil)
                    }
                }
            }.resume()
        }
}
