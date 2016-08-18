//
//  OpenCVImage.m
//  OpenCVRecognizer
//
//  Created by Eugen Fedchenko on 8/18/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//

#import "opencv-headers.h"
#import "OpenCVImage.hpp"

@implementation OpenCVImage {
    CGColorSpaceRef _sourceColorSpaceRef;
    CGImageAlphaInfo _sourceAlphaInfo;
    
    cv::Mat _cvmat;
}

- (instancetype)initWithUIImage:(UIImage *)image
{
    self = [super init];
    
    if (self != nil) {
        
        CGImageRef imageRef = image.CGImage;
        
        _sourceColorSpaceRef = CGImageGetColorSpace(imageRef);
        _sourceAlphaInfo = CGImageGetAlphaInfo(imageRef);
        
        [self initCVMat:imageRef size:image.size];
    }
    
    return self;
}

- (cv::Mat)cvMat
{
    return _cvmat;
}

- (UIImage *)convert2UIImage
{
    NSData *data = [NSData dataWithBytes:_cvmat.data length:_cvmat.elemSize()*_cvmat.total()];
    
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    // Creating CGImage from cv::Mat
    CGImageRef imageRef = CGImageCreate(_cvmat.cols,                                    // width
                                        _cvmat.rows,                                    // height
                                        8,                                              // bits per component
                                        8 * _cvmat.elemSize(),                          // bits per pixel
                                        _cvmat.step[0],                                 // bytesPerRow
                                        _sourceColorSpaceRef,                           // colorspace
                                        _sourceAlphaInfo | kCGBitmapByteOrderDefault,   // bitmap info
                                        provider,                                       // CGDataProviderRef
                                        NULL,                                           // decode
                                        false,                                          // should interpolate
                                        kCGRenderingIntentDefault);
    
    
    // Getting UIImage from CGImage
    UIImage *finalImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    
    return finalImage;
}

#pragma mark - private

- (void)initCVMat:(CGImageRef)imageRef size:(CGSize)size
{
    CGFloat cols = size.width;
    CGFloat rows = size.height;
    
    _cvmat = cv::Mat(rows, cols, CV_8UC4); // 8 bits per component, 4 channels (color channels + alpha)
    
    CGContextRef contextRef = CGBitmapContextCreate(_cvmat.data,                // Pointer to  data
                                                    cols,                       // Width of bitmap
                                                    rows,                       // Height of bitmap
                                                    8,                          // Bits per component
                                                    _cvmat.step[0],             // Bytes per row
                                                    _sourceColorSpaceRef,
                                                    _sourceAlphaInfo | kCGBitmapByteOrderDefault);
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), imageRef);
    CGContextRelease(contextRef);
}


@end
