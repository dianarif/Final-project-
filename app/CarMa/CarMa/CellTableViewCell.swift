//
//  CellTableViewCell.swift
//  CarMa
//
//  Created by Tianze Huang on 3/6/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell
{


    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var features: UILabel!
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
