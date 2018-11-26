//
//  ImageManager.swift
//  ImageGalleryApp
//
//  Created by Admin on 11/26/18.
//  Copyright © 2018 Maksym Gontar. All rights reserved.
//

import Foundation
import Reachability
import NotificationBannerSwift

class ImageManager {
    var reachability = Reachability()!
    
    func configReachability() {
        self.reachability = Reachability()!
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            let banner = StatusBarNotificationBanner(title: "Reachable via WiFi", style: .success)
            banner.show()
        case .cellular:
            print("Reachable via Cellular")
            let banner = StatusBarNotificationBanner(title: "Reachable via Cellular", style: .success)
            banner.show()
        case .none:
            print("Network not reachable")
            let banner = StatusBarNotificationBanner(title: "Network not reachable", style: .warning)
            banner.show()
        }
    }
    
    private static var sharedImageManager: ImageManager = {
        let imageManager = ImageManager()
        
        imageManager.configReachability()
        
        return imageManager
    }()
    
    private init() {}
    
    class func shared() -> ImageManager {
        return sharedImageManager
    }
    
    func getAllImages(completionHandler: @escaping ([Image], Error?) -> Void) {
        switch reachability.connection {
            case .none:
                completionHandler(Image.getAllImages(), nil)
            default:
                WebAPI.getAllImages(completionHandler: completionHandler)
        }
    }
}
