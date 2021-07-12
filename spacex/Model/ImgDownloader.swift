//
//  ImgDownloader.swift
//  meteo
//
//  Created by Martin on 06/07/2021.
//

import Foundation
import UIKit

protocol ImgDownloaderDelegate: AnyObject {
    func downloadFinished(data: Data?, launch: Launch)
    func downloadImagesFinished(data: [Data]?, launch: Launch)
}

private let kMaxImages = 4

class ImgDownloader {
    weak var delegate: ImgDownloaderDelegate?
    
    func getIcon(launch: Launch) {
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
    
    func getImage(launch: Launch) {
        guard let icon = launch.links?.flickr?.original?.first else {
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
    
    func getImages(launch: Launch) {
        guard let icons = launch.links?.flickr?.original?.prefix(kMaxImages) else {
            return
        }
        let session = URLSession(configuration: .default)
        var allData: [Data] = [] {
            didSet {
                if allData.count == kMaxImages {
                    self.delegate?.downloadImagesFinished(data: allData, launch: launch)
                }
            }
        }
        for eachImage in icons {
            
            guard let iconUrl = URL(string: eachImage) else { return
            }
            
            let download = session.dataTask(with: iconUrl) { data, response, error in
                if let _ = error {
                    print("error 1")
                } else {
                    if (response as? HTTPURLResponse) != nil {
                        allData.append(data ?? Data())
                    }
                }
            }
            download.resume()
        }
    }
}
