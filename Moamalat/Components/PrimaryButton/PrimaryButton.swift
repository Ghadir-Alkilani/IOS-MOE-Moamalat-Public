//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 28/11/1442 AH.
//

import UIKit

@IBDesignable
class PrimaryButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        self.setupView()
    }
    
    func setupView() {
        
        backgroundColor = .MoamalatDarkBlue
        setTitleColor(.white, for: .normal)
        cornerRadius = 10.0
        titleLabel?.font = UIFont.jFFlatRegular(fontSize: 18)
    }
}
