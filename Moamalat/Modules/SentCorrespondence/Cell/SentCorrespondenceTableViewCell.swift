//
//  SentCorrespondenceTableViewCell.swift
//  Moamalat
//
//  Created by Ghadir kilani on 17/01/1443 AH.
//

import UIKit

class SentCorrespondenceTableViewCell: UITableViewCell {
    @IBOutlet weak var corressTitle: UILabel!
    @IBOutlet weak var corressType: UILabel!
    @IBOutlet weak var corressNum: UILabel!
    @IBOutlet weak var corressDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        corressNum.font = UIFont.jFFlatRegular(fontSize: 15)
        corressTitle.font = UIFont.jFFlatRegular(fontSize: 15)
        corressDate.font = UIFont.jFFlatRegular(fontSize: 15)
        corressType.font = UIFont.jFFlatRegular(fontSize: 15)
    }

}
