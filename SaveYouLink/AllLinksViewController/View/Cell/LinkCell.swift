//
//  LinkCell.swift
//  SaveYouLink
//
//  Created by Никита Пережогин on 18.08.2020.
//  Copyright © 2020 Nikita Perezhogin. All rights reserved.
//

import UIKit

class LinkCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var urlLink: UILabel!
    @IBOutlet weak var imageLink: UIImageView!
    
    func configure(link: LinkItem){
        title.text = link.title
        urlLink.text = link.urlLink
    }
}
