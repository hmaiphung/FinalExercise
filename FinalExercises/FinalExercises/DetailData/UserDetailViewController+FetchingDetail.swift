//
//  UserDetailViewController+FetchingDetail.swift
//  FinalExercises
//
//  Created by Phung Huy on 30/08/2023.
//

import Foundation

class NetworkDetail {

    static func fetchingDetail(URL url: String, completion: @escaping ([String: Any]) -> Void) {
        guard let url = URL(string: url) else {
            return
        }
    
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Có lỗi xảy ra:", error)
                    return
                }
        
                if let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            completion(json)
                        }
                    } catch {
                        print("Không thể parse dữ liệu:", error)
                    }
                }
            }
    
        dataTask.resume()
    }
    
    
    
}
