//
//  NetworkService.swift
//  ChuckNorrisJoke
//
//  Created by Eduard Ovchinnikov on 30.12.2019.
//  Copyright © 2019 Eduard Ovchinnikov. All rights reserved.
//

import UIKit
import Alamofire

class NetworkService {
    
    func fetchResponse(count: Int, completion: @escaping ([Joke?]) -> Void)  {
        let url = "http://api.icndb.com/jokes/random/\(count)"
        
        Alamofire.request(url, method: .get).responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error received requestiong data: \(error.localizedDescription)")
                completion([])
                return
            }
            guard let data = dataResponse.data else { return }
            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(SearchResponse.self, from: data) as SearchResponse
                let jokes = response.value
                completion(jokes)
            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion([])
            }
        }
    }
    
    
}
