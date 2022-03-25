//
//  TodoTableViewCell.swift
//  Shopping List
//
//  Created by Sebastian Banks on 3/25/22.
//

import UIKit

protocol ItemCellDelegate: AnyObject {
    func toggleIsDone(for cell: ItemTableViewCell)
}

class ItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var itemButton: UIButton!
    @IBOutlet weak var itemLabel: UILabel!
    
    weak var delegate: ItemCellDelegate?
    
    func updateView(item: Item) {
        itemLabel.text = item.itemName
        itemButton.setImage(item.isDone ? UIImage(named: "complete") : UIImage(named: "incomplete"), for: .normal)
    }
    
    @IBAction func itemButtonTapped(_ sender: Any) {
        delegate?.toggleIsDone(for: self)
    }
    
}
