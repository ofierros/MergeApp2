//
//  HistoryCellTableViewCell.swift
//  HeartAI
//
//  Created by Cody Smith on 6/23/20.
//  Copyright © 2020 Algorrhythmics. All rights reserved.
//

import UIKit

class HistoryCellTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
