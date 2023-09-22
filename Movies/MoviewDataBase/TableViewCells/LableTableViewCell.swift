//
//  LableTableViewCell.swift
//  Movies
//
//  Created by Softsuave on 22/09/2023.
//

import UIKit

class LableTableViewCell: UITableViewCell, TableViewCellProtocol {
    
    func configure(with data: Any) {
        if let data = data as? String {
            self.textLabel?.text = data
        }
    }
}

