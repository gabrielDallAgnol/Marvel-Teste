//
//  Character.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 22/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import ObjectMapper

struct Character {
    
    var description: String?
    var id: Int?
    var name: String?
    var thumbnail: Thumbnail?
    
}

extension Character: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        description                <- map["description"]
        id                         <- map["id"]
        name                       <- map["name"]
        thumbnail                  <- map["thumbnail"]
    }
    
}



