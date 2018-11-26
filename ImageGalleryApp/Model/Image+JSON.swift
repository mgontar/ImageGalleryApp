//
//  Image+JSON.swift
//  ImageGalleryApp
//
//  Created by Admin on 11/26/18.
//  Copyright © 2018 Maksym Gontar. All rights reserved.
//

import RealmSwift

extension Image {
    class func fromUrlString(urlString:String) -> Image? {
        let realm = try! Realm()
        
        var result:Image?
        
        if let image = realm.objects(Image.self).filter("url == \"\(urlString)\"").first
        {
            
            result = image
        }
        else{
            let image = Image()
            image.url = urlString
            try! realm.write {
                realm.add(image)
            }
            result = image
        }

        return result
    }
}
