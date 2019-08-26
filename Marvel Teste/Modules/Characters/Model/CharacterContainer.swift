//
//  CharacterDataContainer.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 22/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import ObjectMapper

struct CharacterContainer {
    
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var result = [Character]()
    
}

extension CharacterContainer: Mappable {
    
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
