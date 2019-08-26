//
//  ComicContainer.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 26/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import ObjectMapper

struct ComicContainer {
    
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var result = [Comic]()
    
}

extension ComicContainer: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        offset                  <- map["offset"]
        limit                   <- map["limit"]
        total                   <- map["total"]
        count                   <- map["count"]
        result                  <- map["results"]
    }
    
}
