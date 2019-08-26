//
//  ComicWrapper.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 26/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import ObjectMapper

struct ComicWrapper {
    
    var status: String?
    var message: String? = ""
    var data: ComicContainer?
    
}

extension ComicWrapper: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        status                 <- map["status"]
        message                <- map["message"]
        data                   <- map["data"]
    }
    
}
