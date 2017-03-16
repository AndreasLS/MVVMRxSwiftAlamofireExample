//
//  ViewController.swift
//  MVVMRxSwiftExample
//
//  Created by Andre Salla on 16/03/17.
//  Copyright © 2017 Andre Salla. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ViewModel()
    let dispose = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        viewModel.listObservable.bindTo(tableView.rx.items)  { (table, index, valor: (codigo: Int, nome: String)) -> UITableViewCell in
            let cell = table.getDefaultCell(with: "cell")
            cell.textLabel?.text = valor.nome
            return cell
        }.addDisposableTo(dispose)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

