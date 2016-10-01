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
        
        bottomBar.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        enableButton(blurButton, enable: false)
        
        processor = RecognizerProcessor(view: self)
    }

    // MARK: RecognizerViewProtocol
    
    var processor: RecognizerProcessorProtocol?
    
    func updateImage(_ image : UIImage) {
        imageView.image = image
    }
    
    
    // MARK: Actions
    
    @IBAction func onRecognize(_ sender: AnyObject) {
        if processor!.recognize() {
            enableButton(blurButton, enable: true)
            enableButton(recognizeButton, enable: false)
        }
    }

    
    @IBAction func onBlurRecognizer(_ sender: AnyObject) {
        processor?.blur()
        enableButton(blurButton, enable: false)
    }
    
    
    @IBAction func onNewPhoto(_ sender: AnyObject) {
        
        let actionSheet = UIAlertController(title: "New Image", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.showPicker(.camera)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .default, handler: { _ in
            self.showPicker(.photoLibrary)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil);
        
    }
    
    @IBAction func onSaveImage(_ sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Save image", imageView.image!], applicationActivities: nil)
        present(activityController, animated: true, completion: nil);
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            processor?.newImage(image)
            enableButton(blurButton, enable: false)
            enableButton(recognizeButton, enable: true)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }


    // MARK: private
    func enableButton(_ button: UIButton, enable: Bool) {
        if enable {
            button.isEnabled = true
            button.alpha = 1.0
        } else {
            button.isEnabled = false
            button.alpha = 0.4
        }
    }
    
    func showPicker(_ type: UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = type
        
        present(picker, animated: true, completion: nil)
    }

}

