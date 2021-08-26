//
//  PrivateTableViewCell.swift
//  Moamalat
//
//  Created by Ghadir kilani on 02/12/1442 AH.
//

import UIKit

class PrivateTableViewCell: UITableViewCell {
    @IBOutlet weak var corressTitle: UILabel!
    @IBOutlet weak var corressType: UILabel!
    @IBOutlet weak var corressNum: UILabel!
    @IBOutlet weak var corressDate: UILabel!
    @IBOutlet weak var ccImage: UIImageView!
    
    @IBOutlet weak var lockedImage: UIImageView!
    
    @IBOutlet weak var deptName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        corressTitle.font = UIFont(name: Fonts.JFFlatRegular, size: 15)
        corressType.font = UIFont(name: Fonts.JFFlatRegular, size: 13)
        corressNum.font = UIFont(name: Fonts.JFFlatRegular, size: 13)
        corressDate.font = UIFont(name: Fonts.JFFlatRegular, size: 13)
        deptName.font = UIFont(name: Fonts.JFFlatRegular, size: 13)
        
//        corressType.roundCorners(corners: .bottomLeft, radius: 20)
//        corressType.roundCorners(corners: .bottomRight, radius: 20)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
