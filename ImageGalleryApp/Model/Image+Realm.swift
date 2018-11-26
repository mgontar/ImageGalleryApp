//
//  Image+Realm.swift
//  ImageGalleryApp
//
//  Created by Admin on 11/26/18.
//  Copyright © 2018 Maksym Gontar. All rights reserved.
//

import RealmSwift

extension Image {
    class func getAllImages() -> [Image] {
        var result = [Image]()
        let realm = try! Realm()
        result = realm.objects(Image.self).map(){$0}
        return result
    }
}
