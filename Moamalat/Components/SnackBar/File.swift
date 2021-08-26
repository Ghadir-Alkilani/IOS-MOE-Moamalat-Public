//
//  File.swift
//  Moamalat
//
//  Created by Ghadir kilani on 16/01/1443 AH.
//

import Foundation
import SnackBar
class AppSnackBar: SnackBar {
    
    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .red
        style.textColor = .white
        return style
    }
}

