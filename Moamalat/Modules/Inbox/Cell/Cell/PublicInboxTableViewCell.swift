//
//  PublicTableViewCell.swift
//  Moamalat
//
//  Created by Ghadir kilani on 02/12/1442 AH.
//

import UIKit

class PublicTableViewCell: UITableViewCell {
    @IBOutlet weak var depNameLable: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        depNameLable.font = UIFont(name: Fonts.JFFlatRegular, size: 20)
        // Configure the view for the selected state
    }
    
}
