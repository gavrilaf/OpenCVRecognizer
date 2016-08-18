//
//  OpenCVRecognizer.h
//  OpenCVRecognizer
//
//  Created by Eugen Fedchenko on 8/18/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpenCVRecognizer : NSObject

- (instancetype _Nullable)initWithImage:(UIImage * _Nonnull)image;

- (BOOL)recognize;
- (void)blurRecognized;

- (UIImage * _Nonnull)processedImage;

@end
