//
//  WebService.swift
//  RxSwiftDemo
//
//  Created by 家齊 on 2017/2/22.
//  Copyright © 2017年 張家齊. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WebService {
    static let shared = WebService()
    
    private let manager = Alamofire.SessionManager()
    
    func downloadImage(filename: String, url: String, completeHandle: @escaping (UIImage?) -> ()) {
        let destination: DownloadRequest.DownloadFileDestination = {
            _, _ in
            let fileURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        manager.download(url, to: destination).response(completionHandler: {
            response in
            if response.error == nil, let imagePath = response.destinationURL?.path {
                completeHandle(UIImage(contentsOfFile: imagePath))
            } else {
                completeHandle(nil)
            }
        })
    }
}
