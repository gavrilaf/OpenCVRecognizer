//
//  RecognizerProcessor.swift
//  OpenCVRecognizer
//
//  Created by Eugen Fedchenko on 8/18/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//

import UIKit


class RecognizerProcessor: RecognizerProcessorProtocol {
    
    var originalImage : UIImage
    var recognizer : OpenCVRecognizer?
    
    init(view: RecognizerViewProtocol)
    {
        self.view = view
        originalImage = UIImage(named: "car-plates")!
        view.updateImage(originalImage)
    }
    
    
    // MARK: RecognizerProcessorProtocol
    
    var view: RecognizerViewProtocol
    
    func recognize() -> Bool {
        recognizer = OpenCVRecognizer(image: originalImage)
        
        let found = recognizer?.recognize()
        
        let img = recognizer?.processedImage()
        view.updateImage(img!)
        
        return found!
    }
    
    func blur()
    {
        recognizer?.blurRecognized();
        
        let img = recognizer?.processedImage()
        view.updateImage(img!)
    }
    
    func newImage(image: UIImage)
    {
        originalImage = image
        view.updateImage(originalImage)
    }
}
