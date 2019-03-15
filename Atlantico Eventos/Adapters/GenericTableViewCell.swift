//
//  GenericTableViewCell.swift
//  Atlantico Eventos
//
//  Created by Augusto Firmino on 1/18/19.
//  Copyright © 2019 INOKRI. All rights reserved.
//

import UIKit

class GenericTableViewCell: UITableViewCell {

    @IBOutlet weak var vwContorno: UIView!
    @IBOutlet weak var imgInfo: UIImageView!
    @IBOutlet weak var lblinfo: UILabel!
    @IBOutlet weak var vwbBack: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
