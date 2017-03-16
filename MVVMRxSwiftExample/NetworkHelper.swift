//
//  NetworkHelper.swift
//  MVVMRxSwiftExample
//
//  Created by Andre Salla on 16/03/17.
//  Copyright © 2017 Andre Salla. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift
import SwiftyJSON

protocol RawParseable {
    init?(_ data: Data)
}

protocol Parseable: RawParseable {
    init?(json: JSON)
}

struct ArrayParseable<T: Parseable>: RawParseable {
    let array: [T]
    init?(_ data: Data) {
        if let arrayJson = JSON(data: data).array {
            array = arrayJson.flatMap{T.init(json: $0)}
        } else {
            return nil
        }
    }
}

enum InternalError: Error {
    case NetworkError
    case ParseError
    case BusinessError(message: String)
    
    var localizedDescription: String {
        switch (self) {
        case .NetworkError:                 return "Erro de rede"
        case .ParseError:                   return "Erro ao parsear dados"
        case .BusinessError(let mensagem):  return mensagem
        }
    }
}

fileprivate class API<T: RawParseable> {
    
    static func call(in url: String) -> Observable<T> {
        return RxAlamofire.requestData(.get, url).flatMap{(response, data) -> Observable<T> in
            if response.isSuccess {
                if let parsed = T.init(data) {
                    return Observable.just(parsed)
                } else {
                    return Observable.error(InternalError.ParseError)
                }
            } else {
                return Observable.error(InternalError.BusinessError(message: "Tente novamente mais tarde."))
            }
        }
    }
    
}

extension HTTPURLResponse {
    
    var isSuccess: Bool {
        return 200..<300 ~= statusCode
    }
    
}

struct APIHelper {
    
    static private let URL_SERVER = "https://fipe-parallelum.rhcloud.com/api/v1"
    
    struct Marcas {
        
        static private let urlMarcas = "/carros/marcas"
        
        static func getMarcas() -> Observable<ArrayParseable<Marca>> {
            return API<ArrayParseable<Marca>>.call(in: URL_SERVER + urlMarcas)
        }
    }
}
