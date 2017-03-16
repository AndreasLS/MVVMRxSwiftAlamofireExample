//
//  Marca.swift
//  MVVMRxSwiftExample
//
//  Created by Andre Salla on 16/03/17.
//  Copyright © 2017 Andre Salla. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Marca: Parseable {
    
    let nome: String
    let codigo: Int
    
    init?(json: JSON) {
        guard let _nome = json["nome"].string,
            let _codigo = json["codigo"].int else {
            return nil
        }
        nome = _nome
        codigo = _codigo
    }
    
    init?(_ data: Data) {
        self.init(json: JSON(data: data))
    }
}
