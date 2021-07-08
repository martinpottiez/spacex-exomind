//
//  ImgDownloader.swift
//  meteo
//
//  Created by Martin on 06/07/2021.
//

import Foundation

protocol ImgDownloaderDelegate: AnyObject {
    func downloadFinished(data: Data?, launch: Launch)
}

class ImgDownloader {
    weak var delegate: ImgDownloaderDelegate?
    
    func getImage(launch: Launch) {
        guard let icon = launch.links?.patch?.small else {
            return
        }
        let session = URLSession(configuration: .default)
        guard let iconUrl = URL(string: icon) else { return
        }
        let download = session.dataTask(with: iconUrl) { [weak self] data, response, error in
            if let _ = error {
                print("error 1")
            } else {
                if (response as? HTTPURLResponse) != nil {
                    self?.delegate?.downloadFinished(data: data, launch: launch)
                }
            }
        }
        download.resume()
    }
}
