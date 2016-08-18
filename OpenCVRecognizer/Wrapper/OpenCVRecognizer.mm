//
//  OpenCVRecognizer.m
//  OpenCVRecognizer
//
//  Created by Eugen Fedchenko on 8/18/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//


#import "opencv-headers.h"
#include <vector>
#import "OpenCVRecognizer.h"
#import "OpenCVImage.hpp"

using namespace std;

@interface OpenCVRecognizer()

@property (nonatomic, strong) OpenCVImage *image;

@end

//////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation OpenCVRecognizer {
    cv::CascadeClassifier _classifier;
    vector<cv::Rect> _objects;
}

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self != nil) {
        
        NSString* classifierPath = [[NSBundle mainBundle] pathForResource:@"haarcascade_russian_plate_number" ofType:@"xml"];
        _classifier.load([classifierPath UTF8String]);
        
        _image = [[OpenCVImage alloc] initWithUIImage:image];
    }
    
    return self;
}

- (BOOL)recognize
{
    cv::Mat prepared = [self prepareImage4Recognizing];
    
    _classifier.detectMultiScale(prepared, _objects);
    
    cv::Mat img = _image.cvMat;
    for (auto it = begin(_objects); it != end(_objects); ++it) {
        cv::rectangle(img, *it, cv::Scalar(255, 255, 0), 4);
    }
    
    return !_objects.empty();
}

- (void)blurRecognized
{
    for (auto it = begin(_objects); it != end(_objects); ++it) {
        cv::Mat roi = cv::Mat(_image.cvMat, *it);
        cv::blur(roi, roi, cv::Size(20, 20));
    }
}

- (UIImage *)processedImage
{
    return [_image convert2UIImage];
}

#pragma mark - private

- (cv::Mat)prepareImage4Recognizing
{
    cv::Mat gray;
    
    cv::cvtColor(_image.cvMat, gray, CV_BGR2GRAY);
    equalizeHist(gray, gray);
    
    return gray;
}




@end
