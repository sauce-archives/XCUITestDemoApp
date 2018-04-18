//
//  CustomButtonView.swift
//  ToDoSample
//
//  Created by David on 18.04.18.
//  Copyright © 2018 Saucelabs. All rights reserved.
//

import UIKit

class CustomButtonView: UIView {
    
    var handler: (() -> Void)?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeGestureRecognizer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeGestureRecognizer()
    }
    
    private func initializeGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tapGesture)
    }
    
    @objc
    func tapped() {
        guard let handler = self.handler else {
            return
        }
        handler()
    }
}
