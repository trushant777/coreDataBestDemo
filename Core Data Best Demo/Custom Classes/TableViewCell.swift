//
//  TableViewCell.swift
//  Core Data Best Demo
//
//  Created by Trushant on 17/12/18.
//  Copyright © 2018 Esense. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCellAccordingToModel(songModel:Song)
    {
        self.titleLabel.text = songModel.title
        self.artistLabel.text = songModel.artist
        self.thumbImg.sd_setImage(with: URL.init(string: songModel.urlString), completed: nil)
    }

 

}
