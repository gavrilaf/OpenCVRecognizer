//
//  ProcessorProtocols.swift
//  OpenCVRecognizer
//
//  Created by Eugen Fedchenko on 8/18/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//

import UIKit

protocol RecognizerViewProtocol
{
    var processor: RecognizerProcessorProtocol? { get }
    
    func updateImage(image : UIImage)
}


protocol RecognizerProcessorProtocol
{
    var view: RecognizerViewProtocol { get }
    
    func recognize() -> Bool
    func blur()
    func newImage(image: UIImage)
}


