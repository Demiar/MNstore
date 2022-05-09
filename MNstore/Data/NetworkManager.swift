//
//  NetworkManager.swift
//  MNstore
//
//  Created by Алексей on 03.05.2022.
//

import Foundation


class NetworkManager {
    
    func loadData <T: Decodable> (urlString: String, parameters: [String: String], completion: @escaping (Result<T,Error>) -> Void) {
        let url = URL(string: urlString)
        guard let requestUrl = url else { fatalError() }

        var request = URLRequest(url: requestUrl)
        request.httpMethod = "POST"
        
        let postString = try? JSONSerialization.data(withJSONObject: parameters)

        request.httpBody = postString

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error took place \(error)")
                }
                if let data = data {
                    do{
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(decodedData))
                        }
                    } catch {
                        print(error)
                    }

                }
        }
        task.resume()
    }
    
    func loadImage(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: urlString)
        guard let validUrl = url else { return }

        let data = try? Data(contentsOf: validUrl)
        if let data = data {
            DispatchQueue.main.async {
                completion(.success(data))
            }
        } else {
            print("error")
        }

    }
}
