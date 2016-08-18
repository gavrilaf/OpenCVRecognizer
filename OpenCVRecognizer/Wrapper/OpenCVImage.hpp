//
//  OpenCVImage.h
//  OpenCVRecognizer
//
//  Created by Eugen Fedchenko on 8/18/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

namespace cv
{
    class Mat;
}

@interface OpenCVImage : NSObject

- (instancetype)initWithUIImage:(UIImage *)image;

- (cv::Mat)cvMat;

- (UIImage *)convert2UIImage;

@end
