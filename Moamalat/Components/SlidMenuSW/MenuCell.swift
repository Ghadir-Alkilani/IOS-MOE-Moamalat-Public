//
//  MenuCell.swift
//  Moamalat
//
//  Created by Ghadir kilani on 23/12/1442 AH.
//

import UIKit

class MenuCell: UITableViewCell {
    @IBOutlet weak var MenuLable: UILabel!
    @IBOutlet weak var menuImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
