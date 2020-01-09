//
//  TableViewCell.swift
//  Wongnai Assignment (Intern)
//
//  Created by Prapawit Patthasirivichot on 6/1/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

import UIKit
import Kingfisher
class TableViewCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var voteCount: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var describe: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    public func setCell(cell: ImageCell){
        self.name.text = cell.name
        self.describe.text = cell.description
        self.describe.layoutIfNeeded()
        self.voteCount.text = "\(cell.votes_count!)"
        self.img.kf.setImage(with:URL(string: cell.image_url!), placeholder: nil, options: nil, progressBlock: nil) {
            result in
        }
    }
}
