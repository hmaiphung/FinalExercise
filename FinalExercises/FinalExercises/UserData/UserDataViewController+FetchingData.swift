//
//  UserDataViewController+FetchingData.swift
//  FinalExercises
//
//  Created by Phung Huy on 30/08/2023.
//

import Foundation


    
    func fetchingData(URL url: String, completion: @escaping ([UserData]) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let userDataArray = try JSONDecoder().decode([UserData].self, from: data)
                    completion(userDataArray)
                } catch {
                    print("Parsing error: \(error)")
                    completion([])
                }
            } else if let error = error {
                print("Network error: \(error)")
                completion([])
            }
        }
        dataTask.resume()
    }

