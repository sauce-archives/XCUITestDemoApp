//
//  DetailViewController.swift
//  ToDoSample
//
//  Created by David on 17.04.18.
//  Copyright © 2018 Saucelabs. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var buttonContainer: UIView!
    @IBOutlet weak var greenButton: CustomButtonView!
    @IBOutlet weak var redButton: CustomButtonView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var itemTitle: UILabel!
    var item: ListItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitleView(image: #imageLiteral(resourceName: "sauce_logo_large"))
        
        greenButton.handler = { [weak self] () -> Void in
            self?.updateItem(done: true)
        }
        
        redButton.handler = { [weak self] () -> Void in
            self?.updateItem(done: false)
        }
    }
    
    func updateItem(done: Bool) {
        guard let item = self.item else {
            return
        }
        item.done = done
        update(item: item)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let item = self.item {
//            self.updateView(item: item, dispatchTime: .now() + 5.0)
            self.updateView(item: item)
        }
    }
    
    func updateView(item: ListItem, dispatchTime: DispatchTime? = nil) {
        let dispayText = "Title: \(item.title)"
        
        guard let time = dispatchTime else {
            itemTitle.text = dispayText
            return
        }
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        buttonContainer.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: time) { [weak self] in
            self?.activityIndicator.isHidden = true
            self?.activityIndicator.stopAnimating()
            
            guard !dispayText.contains("INVALID") else {
                self?.itemTitle.text = "Error"
                return
            }
            
            self?.buttonContainer.isHidden = false
            self?.itemTitle.text = dispayText
        }
    }

}
