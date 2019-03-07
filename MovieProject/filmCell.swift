//
//  filmCell.swift
//  MovieProject
//
//  Created by Mac on 24.07.2017.
//  Copyright © 2017 Varol. All rights reserved.
//

import UIKit

class filmCell: UITableViewCell {

    @IBOutlet weak var posterImg: UIImageView!
    
    @IBOutlet weak var filmAdiLbl: UILabel!
    
    @IBOutlet weak var filmYiliLbl: UILabel!
    @IBOutlet weak var filmTuruLbl: UILabel!
    @IBOutlet weak var aciklamaLbl: UITextView!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
