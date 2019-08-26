//
//  Constants.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 22/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

final class Constants {
    
    static var imagePlaceholder = "image-placeholder"
    
    final class MarvelAPI {
        static let baseEndpoint:String = "https://gateway.marvel.com:443/v1/public/"
        static let privateKey:String = "8cfd8487432e4b3062303ebe217b08547073bcd6"
        static let publicKey:String = "5ce5f54559949f6fac99f814e848014f"
        static let ts = Date().timeIntervalSince1970
        static var hash:String {
            let string = "\(MarvelAPI.ts)\(MarvelAPI.privateKey)\(MarvelAPI.publicKey)"
            
            return string.md5
        }
        
        static let offset = 20
    }
    
}
