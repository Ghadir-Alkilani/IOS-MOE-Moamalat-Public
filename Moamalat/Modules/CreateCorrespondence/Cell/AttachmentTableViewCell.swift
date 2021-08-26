//
//  AttachmentTableViewCell.swift
//  Moamalat
//
//  Created by Ghadir kilani on 06/01/1443 AH.
//

import UIKit

class AttachmentTableViewCell: UITableViewCell {
    @IBOutlet weak var documentTitleLable: UILabel!
    
    @IBOutlet weak var byLable: UILabel!
    @IBOutlet weak var documentImage: UIImageView!
    @IBOutlet weak var byValue: UILabel!
    
    @IBOutlet weak var numvalue: UILabel!
    @IBOutlet weak var numLable: UILabel!
    
    @IBOutlet weak var sizeValue: UILabel!
    @IBOutlet weak var sizeLable: UILabel!
    @IBOutlet weak var editDateLable: UILabel!
    @IBOutlet weak var editDateValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        byLable.font = UIFont.jFFlatRegular(fontSize: 15)
        documentTitleLable.font = UIFont.jFFlatRegular(fontSize: 15)
        byValue.font = UIFont.jFFlatRegular(fontSize: 15)
        numvalue.font = UIFont.jFFlatRegular(fontSize: 15)
        sizeValue.font = UIFont.jFFlatRegular(fontSize: 15)
        sizeLable.font = UIFont.jFFlatRegular(fontSize: 15)
        editDateValue.font = UIFont.jFFlatRegular(fontSize: 15)
        byLable.font = UIFont.jFFlatRegular(fontSize: 15)
        editDateLable.font  = UIFont.jFFlatRegular(fontSize: 15)
        // Configure the view for the selected state
    }

}
