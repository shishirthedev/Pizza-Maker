//
//  SSPickerView.swift
//  Pizza Maker
//
//  Created by Developer Shishir on 5/25/19.
//  Copyright © 2019 Shishir's App Studio. All rights reserved.
//

import Foundation

import Foundation
import UIKit

protocol SSPickerViewDelegate: class {
    func didTapDone()
}

class SSPickerView: UIPickerView {
    
    public private(set) var toolbar: UIToolbar?
    public weak var toolbarDelegate: SSPickerViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        
        // PickerView Background Color
         self.backgroundColor = UIColor.white
        
        // Creating Toolbar
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        
        // Adding done button with Toolbar
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(self.doneTapped))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace,
                                          target: nil,
                                          action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.toolbar = toolBar
    }
    
    @objc func doneTapped() {
        self.toolbarDelegate?.didTapDone()
    }
}
