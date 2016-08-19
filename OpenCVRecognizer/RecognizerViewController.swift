//
//  ViewController.swift
//  OpenCVRecognizer
//
//  Created by Eugen Fedchenko on 8/18/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//

import UIKit

class RecognizerViewController: UIViewController, RecognizerViewProtocol,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomBar: UIView!
    
    @IBOutlet weak var blurButton: UIButton!
    @IBOutlet weak var recognizeButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        bottomBar.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
        enableButton(blurButton, enable: false)
        
        processor = RecognizerProcessor(view: self)
    }

    // MARK: RecognizerViewProtocol
    
    var processor: RecognizerProcessorProtocol?
    
    func updateImage(image : UIImage) {
        imageView.image = image
    }
    
    
    // MARK: Actions
    
    @IBAction func onRecognize(sender: AnyObject) {
        if processor!.recognize() {
            enableButton(blurButton, enable: true)
            enableButton(recognizeButton, enable: false)
        }
    }

    
    @IBAction func onBlurRecognizer(sender: AnyObject) {
        processor?.blur()
        enableButton(blurButton, enable: false)
    }
    
    
    @IBAction func onNewPhoto(sender: AnyObject) {
        
        let actionSheet = UIAlertController(title: "New Image", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { _ in
            self.showPicker(.Camera)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { _ in
            self.showPicker(.PhotoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        presentViewController(actionSheet, animated: true, completion: nil);
        
    }
    
    @IBAction func onSaveImage(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Save image", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil);
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            processor?.newImage(image)
            enableButton(blurButton, enable: false)
            enableButton(recognizeButton, enable: true)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
    
    func showPicker(type: UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = type
        
        presentViewController(picker, animated: true, completion: nil)
    }

}

