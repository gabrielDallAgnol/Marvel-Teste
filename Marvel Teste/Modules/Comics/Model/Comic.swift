//
//  Comic.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 26/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import ObjectMapper

struct Comic {
    
    var description: String?
    var id: Int?
    var title: String?
    var thumbnail: Thumbnail?
    
}

extension Comic: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        description                <- map["description"]
        id                         <- map["id"]
        title                      <- map["title"]
        thumbnail                  <- map["thumbnail"]
    }
    
}
