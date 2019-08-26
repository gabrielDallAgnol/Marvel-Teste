//
//  Creator.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 26/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import ObjectMapper

struct Creator {
    
    var id: Int?
    var fullName: String?
    var thumbnail: Thumbnail?
    
}

extension Creator: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        fullName                   <- map["fullName"]
        id                         <- map["id"]
        thumbnail                  <- map["thumbnail"]
    }
    
}
