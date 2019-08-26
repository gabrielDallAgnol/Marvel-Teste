//
//  MarvelService.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 22/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RxSwift

class MarvelService {
    
    static func fetchCharacters(query: String = "", limit: Int, offset: Int) -> Observable<[Character]> {
       
        var parameters: Parameters = [
            "apikey": Constants.MarvelAPI.publicKey,
            "ts": Constants.MarvelAPI.ts,
            "hash": Constants.MarvelAPI.hash,
            "limit": limit,
            "offset": offset,
            "nameStartsWith": query
        ]
        
        if query == "" {
            parameters.removeValue(forKey: "nameStartsWith")
        }
        
        return Observable<[Character]>.create { observer -> Disposable in
            let request = AF
                .request(Endpoints.Characters.fetch.url, method: .get, parameters: parameters)
                .validate()
                .responseObject(completionHandler: { (response: DataResponse<CharacterWrapper>) in
                    switch response.result {
                    case .success(let wrapper):
                        let characters = wrapper.data?.result
                        observer.onNext(characters ?? [])
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                })
            
            return Disposables.create(with: {
                request.cancel()
            })
        }
    }
    
    static func fetchComics(query: String = "", limit: Int, offset: Int) -> Observable<[Comic]> {
        
        var parameters: Parameters = [
            "apikey": Constants.MarvelAPI.publicKey,
            "ts": Constants.MarvelAPI.ts,
            "hash": Constants.MarvelAPI.hash,
            "limit": limit,
            "offset": offset,
            "titleStartsWith": query
        ]
        
        if query == "" {
            parameters.removeValue(forKey: "titleStartsWith")
        }
        
        return Observable<[Comic]>.create { observer -> Disposable in
            let request = AF
                .request(Endpoints.Comics.fetch.url, method: .get, parameters: parameters)
                .validate()
                .responseObject(completionHandler: { (response: DataResponse<ComicWrapper>) in
                    print(response)
                    switch response.result {
                    case .success(let wrapper):
                        let comics = wrapper.data?.result
                        observer.onNext(comics ?? [])
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                })
            
            return Disposables.create(with: {
                request.cancel()
            })
        }
    }
    
    static func fetchCreators(query: String = "", limit: Int, offset: Int) -> Observable<[Creator]> {
        
        var parameters: Parameters = [
            "apikey": Constants.MarvelAPI.publicKey,
            "ts": Constants.MarvelAPI.ts,
            "hash": Constants.MarvelAPI.hash,
            "limit": limit,
            "offset": offset,
            "nameStartsWith": query
        ]
        
        if query == "" {
            parameters.removeValue(forKey: "nameStartsWith")
        }
        
        return Observable<[Creator]>.create { observer -> Disposable in
            let request = AF
                .request(Endpoints.Creators.fetch.url, method: .get, parameters: parameters)
                .validate()
                .responseObject(completionHandler: { (response: DataResponse<CreatorWrapper>) in
                    print(response)
                    switch response.result {
                    case .success(let wrapper):
                        let creator = wrapper.data?.result
                        observer.onNext(creator ?? [])
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
                })
            
            return Disposables.create(with: {
                request.cancel()
            })
        }
    }
}
