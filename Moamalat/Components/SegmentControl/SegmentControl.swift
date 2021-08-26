//
//  segmentControl.swift
//  Moamalat
//
//  Created by Ghadir kilani on 02/12/1442 AH.
//

import UIKit
protocol CustomSegmentedControlDelegate:class {
    func change(to index:Int)
}
//@IBDesignable
class CustomSegmentedControl: UIControl {
    public var onValueChanged: ((_ index: Int)->())?
    private var buttonTitles:[String]!
    private var buttons: [UIButton]!
    private var bottomView : UIView!
    private var selectorView: UIView!

   var textColor:UIColor = UIColor(hexString: "C7CEDE")
   var selectorViewColor: UIColor = UIColor(hexString: "#A27640")
   var bottomViewColor: UIColor = .clear
   var selectorTextColor: UIColor = UIColor(hexString: "#A27640")

    weak var delegate:CustomSegmentedControlDelegate?

    public private(set) var selectedIndex : Int = 0

    convenience init(frame:CGRect,buttonTitle:[String]) {
        self.init(frame: frame)
        self.buttonTitles = buttonTitle
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.backgroundColor = UIColor.white
        updateView()
    }

    func setButtonTitles(buttonTitles:[String]) {
        self.buttonTitles = buttonTitles

        self.updateView()
    }

   func setIndex(index:Int) {
       buttons.forEach({ $0.setTitleColor(textColor, for: .normal) })
       let button = buttons[index]

       selectedIndex = index
        button.setTitleColor(selectorTextColor, for: .normal)
       let selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(index)
        UIView.animate(withDuration: 0.2) {
           self.selectorView.frame.origin.x = selectorPosition
        }
   }

    @objc func buttonAction(sender:UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            btn.setTitleColor(textColor, for: .normal)
            if btn == sender {
             let   selectorPosition = frame.width/CGFloat(buttonTitles.count) * CGFloat(buttonIndex)
               selectedIndex = buttonIndex
               // print(selectedIndex)
                delegate?.change(to: selectedIndex)
                UIView.animate(withDuration: 0.3) {
//                    self.selectorView.frame.origin.x = selectorPosition
                    self.selectorView.frame.origin.x = btn.frame.origin.x
                }
                 btn.setTitleColor(selectorTextColor, for: .normal)
            }

        }
        onValueChanged?(selectedIndex)
     sendActions(for: .valueChanged)
    }

}

//Configuration View
extension CustomSegmentedControl {
    private func updateView() {
        createButton()
       configBottomView()
        configSelectorView()
        configStackView()
    }

    private func configBottomView(){

        bottomView = UIView(frame: CGRect(x: frame.origin.x, y: self.frame.height, width: self.frame.width, height: 1))
        bottomView.backgroundColor = bottomViewColor
        addSubview(bottomView)
    }

    private func configStackView() {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.backgroundColor = UIColor.clear
        addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        stack.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

    }

    private func configSelectorView() {
        let selectorWidth = frame.width / CGFloat(self.buttonTitles.count)
        if buttonTitles.count == 4 {
            let g = selectorWidth * 3
            selectorView = UIView(frame: CGRect(x: g, y: self.frame.height, width: selectorWidth, height: 2))
        }else  if buttonTitles.count == 2{
            selectorView = UIView(frame: CGRect(x: selectorWidth, y: self.frame.height, width: selectorWidth, height: 2))
        }else  {
            let g = selectorWidth * 4
            selectorView = UIView(frame: CGRect(x: g, y: self.frame.height, width: selectorWidth, height: 2))
        }
       selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
    }

    private func createButton() {
        buttons = [UIButton]()
        buttons.removeAll()
        subviews.forEach({$0.removeFromSuperview()})
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.titleLabel?.font = UIFont.jFFlatRegular(fontSize: 15)
            button.addTarget(self, action:#selector(CustomSegmentedControl.buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons[0].setTitleColor(selectorTextColor, for: .normal)

    }


}

