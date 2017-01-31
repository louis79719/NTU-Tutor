//
//  CustomCheckBox.swift
//  NTU-Tutor
//
//  Created by Louis on 2017/1/31.
//  Copyright © 2017年 Louis's Mac. All rights reserved.
//


import UIKit

@IBDesignable class CustomCheckBox: UIButton {
    
    @IBInspectable var isChecked: Bool = false
    {
        didSet{
            updateViews()
        }
    }
    @IBInspectable var checkedIcon: UIImage? = UIImage( named: "Checked.png" )
    @IBInspectable var uncheckedIcon: UIImage? = UIImage( named: "Unchecked.png" )
    
    //this init fires usually called, when storyboards UI objects created:
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    //This method is called during programmatic initialisation
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    
    func setupViews() {
        //your common setup goes here
        if( isChecked ){
            setImage(checkedIcon, for: .normal)
        }
        else{
            setImage(uncheckedIcon, for: .normal)
        }
    }
    
    func updateViews() {
        if( isChecked ){
            setImage(checkedIcon, for: .normal)
        }
        else{
            setImage(uncheckedIcon, for: .normal)
        }
    }
    
    //required method to present changes in IB
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        //self.setupViews()
    }
    
}
