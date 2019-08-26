//
//  Thumbnail.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 22/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import ObjectMapper

struct Thumbnail {
    
    private var path = ""
    private var fileExtension = ""
    
    func url() -> String {
        return path + "." + fileExtension
    }
}

extension Thumbnail: Mappable {
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        path                <- map["path"]
        fileExtension       <- map["extension"]
    }
    
}
