//
//  SecondaryButton.swift
//  Moamalat
//
//  Created by Ghadir kilani on 03/12/1442 AH.
//

import UIKit

@IBDesignable
class SecondaryButton: UIButton {

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
        cornerRadius = 20.0
       
    }
}
