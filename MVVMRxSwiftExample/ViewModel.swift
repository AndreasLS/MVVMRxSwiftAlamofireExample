//
//  ViewModel.swift
//  MVVMRxSwiftExample
//
//  Created by Andre Salla on 16/03/17.
//  Copyright © 2017 Andre Salla. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel {

    private let listSubject: BehaviorSubject<[(codigo: Int, nome: String)]> = BehaviorSubject(value: [])
    
    let listObservable: Observable<[(codigo: Int, nome: String)]>
    
    let dispose = DisposeBag()
    
    init() {
        listObservable = listSubject.asObservable()
        
        APIHelper.Marcas.getMarcas().map{($0.array.map{($0.codigo, $0.nome)})}.subscribe(listSubject).addDisposableTo(dispose)
        
    }

}
