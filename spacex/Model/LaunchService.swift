//
//  LaunchService.swift
//  spacex
//
//  Created by Martin on 05/07/2021.
//

import Foundation
import UIKit

class LaunchService {

    static var shared = LaunchService()
    private var task: URLSessionTask?
    private init() {}

    func getLaunch(callback: @escaping (Bool, [Launch]?) -> Void) {


        guard let forecastUrl = URL(string: "https://api.spacexdata.com/v4/launches") else {
            return
        }
        var request = URLRequest(url: forecastUrl)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)

        task?.cancel()

        task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("1")
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print("2")
                    callback(false, nil)
                    return
                }
                let decoder = JSONDecoder()
                guard let responseJSON = try? decoder.decode([Launch].self, from: data) else {
                    print(response)
                    callback(false, nil)
                    return
                }
                let launch = responseJSON
                callback(true, launch)
            }
        }
        task?.resume()
    }
}
