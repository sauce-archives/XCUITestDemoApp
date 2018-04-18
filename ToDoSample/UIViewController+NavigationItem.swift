//
//  UIViewController+NavigationItem.swift
//  ToDoSample
//
//  Created by David on 18.04.18.
//  Copyright © 2018 Saucelabs. All rights reserved.
//

import UIKit

extension UIViewController {
    func setTitleView(image: UIImage) {
        let imageView = UIImageView(image: image);
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
}
