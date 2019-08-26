//
//  EndPoints.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 22/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Characters: Endpoint {
        case fetch
        public var path: String {
            switch self {
            case .fetch: return "/characters"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(Constants.MarvelAPI.baseEndpoint)\(path)"
            }
        }
    }
    
    enum Comics: Endpoint {
        case fetch
        public var path: String {
            switch self {
            case .fetch: return "/comics"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(Constants.MarvelAPI.baseEndpoint)\(path)"
            }
        }
    }
    
    enum Creators: Endpoint {
        case fetch
        public var path: String {
            switch self {
            case .fetch: return "/creators"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(Constants.MarvelAPI.baseEndpoint)\(path)"
            }
        }
    }
}
