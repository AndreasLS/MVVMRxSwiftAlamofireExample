//
//  UIHelper.swift
//  MVVMRxSwiftExample
//
//  Created by Andre Salla on 16/03/17.
//  Copyright © 2017 Andre Salla. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func getDefaultCell(with identifier: String) -> UITableViewCell {
        var _cell = self.dequeueReusableCell(withIdentifier: identifier)
        if _cell == nil {
            _cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }
        guard let cell = _cell else {
            fatalError()
        }
        return cell
    }
}
