//
//  ImageCell.swift
//  Wongnai Assignment (Intern)
//
//  Created by Prapawit Patthasirivichot on 6/1/2563 BE.
//  Copyright © 2563 Prapawit Patthasirivichot. All rights reserved.
//

import Foundation
class ImageCell: Decodable{
    var name: String?
    var image_url: String?
    var description: String?
    var votes_count: Int?
    
    init(name: String, img: String, desc:String, vote: Int) {
        self.name = name
        self.image_url = img
        self.description = desc
        self.votes_count = vote
    }
    
}
