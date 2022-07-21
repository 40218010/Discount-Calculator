//
//  ViewController.swift
//  DiscountCalculator
//
//  Created by 林大屍 on 2022/3/15.
//

import UIKit
import SnapKit

class DiscountComputer {
    
    
    //compute property
    var discountPercentage: String {
        return Int(discount * 100).description + "%"
    }
    
    private(set) var discount: Float = 0 {
        didSet {
            valueChanged?(self)
        }
    }
    
    private(set) var price: Float = 0 {
        didSet {
            valueChanged?(self)
        }
    }
    
    var valueChanged: ((DiscountComputer) -> Void)?
    
    var priceAfterDiscount: Float {
        return discount * price
    }
    
    func changeDiscount(_ discount: Float) {
        self.discount = discount
    }
    
    func changePrice(_ text: String?) {
        guard let text = text else {
            return
        }
        self.price = Float(text) ?? 0
    }
}

class ViewController: UIViewController {
        
//    var priceTextFieldText: Int?

    let computer = DiscountComputer()

    
    // MARK: UIs
    let priceLabel: UILabel = {
        let labelOne = UILabel()
        labelOne.text = "原價"
//        labelOne.backgroundColor = .systemCyan
        
        return labelOne
        
    }()
    
    let priceTextField: UITextField = {
        // Create UITextField
        let myTextField: UITextField = UITextField()
        // Set UITextField placeholder text
        myTextField.placeholder = "$$$"
        // Set UITextField border style
        myTextField.borderStyle = UITextField.BorderStyle.line
        // Set UITextField background colour
        myTextField.backgroundColor = UIColor.white
        // Set UITextField text color
        myTextField.textColor = UIColor.blue
        myTextField.keyboardType = .numberPad
        return myTextField
    }()
    
    let slider: UISlider = {
        let mySlider = UISlider()
        mySlider.value = 0
        mySlider.minimumValue = 0
        mySlider.maximumValue = 1
        mySlider.isContinuous = true
        mySlider.tintColor = UIColor.systemYellow
        return mySlider
    }()
    
    let discountLabel: UILabel = {
        let labelTwo = UILabel()
        labelTwo.text = "0%"
        return labelTwo
        
    }()
    
    let afterDiscountTextLabel: UILabel = {
        let labelThree = UILabel()
        labelThree.text = "特價"
        return labelThree
    }()
    
    let afterDiscountNumLabel: UILabel = {
        let labelFour = UILabel()
        labelFour.text = "???"
        return labelFour
    }()
    
    

    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .orange
        setUpViews()
        
        slider.addTarget(self, action: #selector(self.sliderValueDidChange), for: .valueChanged)
        priceTextField.addTarget(self, action: #selector(textFieldEditing), for: .editingChanged)
        
        computer.valueChanged = { computer in
            self.discountLabel.text = "\(computer.discountPercentage)"
            self.afterDiscountNumLabel.text = "\(computer.priceAfterDiscount)"
        }
    }
    
    
    // MARK: Setting Methods
    private func setUpViews() {
        
        let topHStackView = UIStackView(arrangedSubviews: [priceLabel, priceTextField])
        topHStackView.spacing = 10
        view.addSubview(topHStackView)

        
        let middleVStackView = UIStackView(arrangedSubviews: [slider, discountLabel])
        middleVStackView.axis = .vertical
        middleVStackView.spacing = 10
        view.addSubview(middleVStackView)
        
        let bottomHStackView = UIStackView(arrangedSubviews: [afterDiscountTextLabel, afterDiscountNumLabel])
        middleVStackView.spacing = 10
        view.addSubview(bottomHStackView)

        
        let mainVStackView = UIStackView(arrangedSubviews: [topHStackView, middleVStackView, bottomHStackView])
        mainVStackView.axis = .vertical
        mainVStackView.spacing = 10
        view.addSubview(mainVStackView)
        mainVStackView.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        
        

        
        
    }

    // MARK: --Actions
    @objc func sliderValueDidChange(_ sender:UISlider!)
    {
        computer.changeDiscount(sender.value)
    }
    
    @objc func textFieldEditing(_ sender: UITextField) {
        computer.changePrice(sender.text)
    }
    

}



