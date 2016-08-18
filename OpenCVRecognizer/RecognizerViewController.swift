//
//  ViewController.swift
//  OpenCVRecognizer
//
//  Created by Eugen Fedchenko on 8/18/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//

import UIKit

class RecognizerViewController: UIViewController, RecognizerViewProtocol {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var blurButton: UIButton!
    
    var alreadyRecognized: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processor = RecognizerProcessor(view: self)
        
        
        bottomBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        enableButton(blurButton, enable: false)
    }

    // MARK: RecognizerViewProtocol
    var processor: RecognizerProcessorProtocol?
    
    func updateImage(image : UIImage) {
        imageView.image = image
    }
    
    
    // MARK: Actions
    
    @IBAction func onRecognize(sender: AnyObject) {
        if !alreadyRecognized && processor!.recognize() {
            enableButton(blurButton, enable: true)
            alreadyRecognized = true
        }
    }

    
    @IBAction func onBlurRecognizer(sender: AnyObject) {
        processor?.blur()
    }
    
    
    @IBAction func onNewPhoto(sender: AnyObject) {
        enableButton(blurButton, enable: false)
    }

    // MARK: private
    
    func enableButton(button: UIButton, enable: Bool) {
        if enable {
            button.enabled = true
            button.alpha = 1.0
        } else {
            button.enabled = false
            button.alpha = 0.4
        }
    }
}

