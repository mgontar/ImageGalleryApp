//
//  WebAPI.swift
//  ImageGalleryApp
//
//  Created by Admin on 11/26/18.
//  Copyright © 2018 Maksym Gontar. All rights reserved.
//

import Alamofire

class WebAPI {
    
    static let baseUrl = "http://petminder.tangosquared.com/api/"
    
    enum EndPoint: String {
        case allImages = "get-media-urls"
    }
    
    class func getAllImages(completionHandler: @escaping ([Image], Error?) -> Void) {
        let url = baseUrl + EndPoint.allImages.rawValue
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response: DataResponse<Any>) in
            var result = [Image]()
            var resultError:Error? = nil
            switch(response.result) {
            case .success(let value):
                if let array = value as? [String] {
                    for item in array {
                        if let image = Image.fromUrlString(urlString: item) {
                           result.append(image)
                        }
                        else{
                            result = [Image]()
                            resultError = CustomError.parsingError
                        }
                    }
                }
                else
                {
                    resultError = CustomError.serviceError
                }
            case .failure(let error):
                resultError = error
            }
            completionHandler(result, resultError)
        }
    }
}
